import sqlite3
from bottle import *

def home():
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT DISTINCT id FROM Albums WHERE cover_art_file_path IS NOT NULL and cover_art_file_name IS NOT NULL ORDER BY RANDOM() LIMIT 6")
    ids = cursor.fetchall()
    conn.close()
    print ids
    return ids

@error(404)
def error404(error):
    return "Error 404"


@get('/art/<album_id>')
def art_files(album_id):
    
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT cover_art_file_path, cover_art_file_name FROM Albums WHERE id = ?", [album_id])
    results = cursor.fetchall()
    conn.close()
    print results
    if results[0][0] is None:
        return error404("")
    file_name = results[0][1]
    file_path = results[0][0]
    return static_file(file_name, root=file_path)
    # return "File name: " + file_name + " File path: " + file_path

run(host="0.0.0.0", port=8080, debug=True)
