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
        return template("home", email=request.get_cookie("email"))

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

@get('/play/song/<music_id>')
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


def populate_db():
    music_files = find_files(os.path.expanduser("~/"), "*.mp3")
    conn = sqlite3.connect("db/data.db")
    artist_history = []
    album_history = []

    for item in music_files:
        tag = eyeD3.Tag()
        tag.link(item[0] + "/" + item[1])
        artist = tag.getArtist()
        album = tag.getAlbum()
        track = tag.getTitle()

        cursor = conn.cursor()

        try:
            if artist and artist not in artist_history:
                cursor.execute("INSERT INTO Artists (artist_name) VALUES (?)", [artist])
                artist_history.append(artist)
        except sqlite3.IntegrityError:
            print "! Integrity Error !"
        
        try:
            if album and artist and album not in album_history:
                cover_art = find_files(item[0], "*.jpg")
                if len(cover_art) == 1:
                    cursor.execute("INSERT INTO Albums (album_name, artist_name, cover_art_file) VALUES (?, ?, ?)", [album, artist, cover_art[0][0] + "/" + cover_art[0][1]])
                else:
                    cursor.execute("INSERT INTO Albums (album_name, artist_name, cover_art_file) VALUES (?, ?, ?)", [album, artist, "?"])
                album_history.append(album)
        except sqlite3.IntegrityError:
            print "! Integrity Error !"

        try:
            if album and artist and track:
                cursor.execute("INSERT INTO Songs (artist_name, title, album_name, file_path, file_name) VALUES (?, ?, ?, ?, ?)", [artist, track, album, item[0], item[1]])
        except sqlite3.IntegrityError:
            print "! Integrity Error !"

        conn.commit()
        

    conn.close()

populate_db()
run(host="0.0.0.0", port=8080, debug=True)
