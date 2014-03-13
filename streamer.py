import bcrypt, json, sqlite3, os, fnmatch, eyeD3
from bottle import *

master_secret_key = ""

with open("keys", "r") as keys:
    master_secret_key = keys.read()

@error(404)
def error404(error):
    return template("404")

@get('/')
def index():
    redirect("/login")

@get('/login')
def login():
    if request.get_cookie("email") is None:
        return template("login", error=None)
    else:
        redirect("/home")

@get('/login/<error>')
def login_error(error):
    return template("login", error=error)

@get('/static/<filename>')
def serve_static(filename):
    return static_file(filename, root="./static")

@get('/song/<music_id>')
def serve_music(music_id):
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT file_path, file_name FROM Songs WHERE id = ?", [music_id])
    result = cursor.fetchone()
    if result is None:
        return error404(None)
    file_path = result[0]
    file_name = result[1]
    conn.close()
    return static_file(file_name, root=file_path)

@get('/art/<album_id>')
def art_files(album_id):
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT cover_art_file_path, cover_art_file_name FROM Albums WHERE id = ?", [album_id])
    results = cursor.fetchall()
    if results[0][0] is None:
        return error404("")
    file_name = results[0][1]
    file_path = results[0][0]
    return static_file(file_name, root=file_path)

@get('/album/<album_id>')
def album(album_id):
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT album_name FROM Albums WHERE id = ?", [album_id])
    album_name = cursor.fetchone()[0]
    cursor.execute("SELECT * FROM Songs WHERE album_name = ?", [album_name])
    results = cursor.fetchall()
    return template("album", songs=results, email=request.get_cookie("email"))

@post('/auth')
def authenticate():
    global master_secret_key
    email = request.forms.get("email")
    raw_password = request.forms.get("password")

    auth = authenticate_user(email, raw_password)

    if auth is None:
        redirect("/login/none")
    elif not auth:
        redirect("/login/auth")
    elif auth:
        response.set_cookie("email", email)
        redirect("/home")

@get('/signup')
def signup():
    if request.get_cookie("email") is not None:
        redirect("/home")
    else:
        return template("signup", error=None)

@get('/logout')
def logout():
    response.set_cookie("email", "", expires=0)
    redirect("/login")

@get('/signup/<error>')
def signup_error(error):
    return template("signup", error=error)

@post('/signup')
def signup_user():
    email = request.forms.get("email")
    password = request.forms.get("password")
    confirm = request.forms.get("confirm_password")
    
    if (password == confirm):
        try:
            create_user(email, password, False)
            response.set_cookie("email", email)
            redirect("/home")
        except sqlite3.IntegrityError:
            redirect("/signup/dup")
    else:
        redirect("signup/mismatch")

@get('/home')
def home():
    if request.get_cookie("email") is None:
        redirect("login")
    else:
        conn = sqlite3.connect("db/data.db")
        cursor = conn.cursor()
        cursor.execute("SELECT DISTINCT id FROM Albums WHERE cover_art_file_path IS NOT NULL and cover_art_file_name IS NOT NULL ORDER BY RANDOM() LIMIT 6")
        ids = cursor.fetchall()
        conn.close()
        return template("home", email=request.get_cookie("email"), album_art_ids=ids)

def authenticate_user(email, raw_password):
    global master_secret_key
    
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Users WHERE email = ?", [email])
    result = cursor.fetchone()
    if result is None:
        return None
    
    salt = result[2]
    password_hash = result[1]

    given_hash = bcrypt.hashpw(raw_password + salt + master_secret_key, salt)

    conn.close()
    
    return given_hash == password_hash

def create_user(email, raw_password, is_admin):
    global master_secret_key

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(raw_password + salt + master_secret_key, salt)
    
    cursor.execute("INSERT INTO Users (email, password_hash, password_salt, is_admin) VALUES (?, ?, ? , ?)", (email, hashed_password, salt, is_admin))
    conn.commit()
    conn.close()
    
def find_files(directory, pattern):
    files_with_path = []
    for root, dirs, files in os.walk(directory):
        for basename in files:
            if fnmatch.fnmatch(basename, pattern):
                filename = os.path.join(root, basename)
                files_with_path.append([root, basename])

    return files_with_path

def populate_db(directory, extension):
    music_files = find_files(os.path.expanduser(directory), extension)
    conn = sqlite3.connect("db/data.db")
    conn.text_factory = str

    for item in music_files:
        tag = eyeD3.Tag()
        tag.link(item[0] + "/" + item[1])

        artist = tag.getArtist()
        album = tag.getAlbum()
        track = tag.getTitle()
        
        cursor = conn.cursor()



        print "Artist: " + artist + " Album: " + album + " Track: " + track

        try:
            cursor.execute("INSERT INTO Artists (artist_name) VALUES (?)", [artist])
        except sqlite3.IntegrityError:
            print "! Artist Integrity Error !"
        except sqlite3.ProgrammingError:
            print "! Album Programming Error !"
        
        try:
            cover_art = find_files(item[0], "*.jpg")
            params_array = [album, artist.lower()]
            if len(cover_art) == 1:
                params_array.append(cover_art[0][0])
                params_array.append(cover_art[0][1])
            else:
                params_array.append(None)
                params_array.append(None)

            if not tag.getYear():
                print "! No year !"

            params_array.append(str(tag.getYear()))

            genre = tag.getGenre()

            if genre:
                params_array.append(genre.name)
            else:
                params_array.append(None)

            print "Length of params arr: " + str(len(params_array))

            cursor.execute("INSERT INTO Albums (album_name, artist_name, cover_art_file_path, cover_art_file_name, release_year, genre) VALUES (?, ?, ?, ?, ?, ?)", params_array)
            print "Inserting into albums the following params: " + str(params_array)
        except sqlite3.IntegrityError:
            print "! Album Integrity Error !"

        try:
            if album and artist and track:
                params_array = []

                params_array.append(artist.lower())
                params_array.append(track)
                params_array.append(album)

                params_array.append(item[0])
                params_array.append(item[1])

                year = tag.getYear()

                if year:
                    params_array.append(year)
                else:
                    params_array.append(None)
                    
                cursor.execute("INSERT INTO Songs (artist_name, title, album_name, file_path, file_name, release_year) VALUES (?, ?, ?, ?, ?, ?)", params_array)

        except sqlite3.IntegrityError:
            print "! Song Integrity Error !"
        except sqlite3.ProgrammingError:
            print "! Song Programming Error !"

        conn.commit()
        
    conn.close()

populate_db("~/", "*.mp3")

run(host="0.0.0.0", port=8080, debug=True)
