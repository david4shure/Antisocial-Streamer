import bcrypt, json, sqlite3, os, fnmatch, eyeD3, re, populate_database, subprocess, datetime
from helpers import *
from bottle import *
from gevent import monkey; monkey.patch_all()


master_secret_key = ""
secret = "this is a secret...she..U)(%*R$)(()%*#(%*&*(YFUIHJ SD YFKGHJ"

with open("keys", "r") as keys:
    master_secret_key = keys.read()

@error(500)
def internalError(error):
    return template("500")

@error(404)
def error404(error):
    return template("404")

@error(403)
def error403(error):
    return template("403", email=request.get_cookie("email", secret = secret))

@get('/')
def index():
    redirect("/login")

@get('/login')
def login():
    if request.get_cookie("email", secret = secret) is None:
        return template("login", error=None)
    else:
        redirect("/home")

@get('/login/<error>')
def login_error(error):
    return template("login", error=error)

@get('/static/<filename>')
def serve_static(filename):
    return static_file(filename, root="./static")

@get('/images/<filename>')
def serve_images(filename):
    return static_file(filename, root="./images")

@get('/woah')
def woah():
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")
    return template("woah", email=request.get_cookie("email", secret = secret))

@get('/upload')
def get_upload():
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")
    return template("upload", email=request.get_cookie("email", secret = secret), is_admin=check_admin(request.get_cookie("email", secret = secret)))

@get('/upload')
def get_upload():
    return template("upload", email=request.get_cookie("email"), is_admin=check_admin(request.get_cookie("email")))

@get('/manage')
def manage():
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")

    if not check_user_exists(request.get_cookie("email", secret = secret)):
        redirect("/logout")

    if not check_admin(request.get_cookie("email", secret = secret)):
        return error403(None)
    else:
        conn = sqlite3.connect("db/data.db")
        cursor = conn.cursor()
        cursor.execute("SELECT email FROM Users WHERE is_confirmed = 0")
        
        unconfirmed_users = cursor.fetchall()

        cursor.execute("SELECT email FROM Users WHERE is_admin = 0 AND is_confirmed = 1 AND NOT email = ?", [request.get_cookie("email", secret = secret)])
        
        confirmed_users = cursor.fetchall()

        return template("manage", email=request.get_cookie("email", secret = secret), unconfirmed_users = unconfirmed_users, confirmed_users = confirmed_users, is_admin = check_admin(request.get_cookie("email", secret = secret)))

@post('/bestow')
def bestow_admin_status():
    email = request.forms.get("make_admin")
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("UPDATE Users SET is_admin = 1 WHERE email = ?", [email])
    conn.commit()
    conn.close()
    redirect("/manage")

@post('/exile')
def exile_user():
    email = request.forms.get("exile_user")
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("UPDATE Users SET is_confirmed = 0 WHERE email = ?", [email])
    conn.commit()
    conn.close()
    redirect("/manage")

@route('/upload', method='POST')
def do_upload():
    uploaded_files = request.files.getlist("upload")

    for file in uploaded_files:
        name, ext = os.path.splitext(file.filename)
        if ext not in ('.mp3'):
            return "Extension: " + ext + " not allowed!"

    folder_name = datetime.now().strftime("%H%M%S%f")
    upload_path = "/media/external/" + folder_name
    popen = subprocess.Popen("mkdir " + upload_path, shell=True)
    popen.communicate()

    for file in uploaded_files:
        file.save(upload_path)

    populate_database.populate_db(upload_path, "*.mp3")
    redirect("/home")

@post('/confirm')
def confirm_user():
    email = request.forms.get("confirm_user")
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("UPDATE Users SET is_confirmed = 1 WHERE email = ?", [email])
    conn.commit()
    conn.close()
    redirect("/manage")

@get('/song/<music_id>')
def serve_music(music_id):
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()

    cursor.execute("SELECT is_confirmed FROM Users WHERE email = ?", [request.get_cookie("email", secret = secret)])

    can_listen = cursor.fetchone()[0]

    if can_listen == 0:
        redirect("/woah")
    
    cursor.execute("SELECT file_path, file_name FROM Songs WHERE id = ?", [music_id])
    result = cursor.fetchone()
    if result is None:
        return error404(None)
    file_path = result[0]
    file_name = result[1]

    cursor.execute("UPDATE Songs SET hits = hits + 1 WHERE id = ?", [music_id])
    conn.commit()
    conn.close()
    return static_file(file_name, root=file_path)

@get('/art/<album_id>')
def art_files(album_id):

    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT cover_art_file_path, cover_art_file_name FROM Albums WHERE id = ?", [album_id])
    results = cursor.fetchall()
    if results[0][0] is None:
        return static_file("no_album_art.jpg", os.path.expanduser("./"))
    file_name = results[0][1]
    file_path = results[0][0]
    return static_file(file_name, root=file_path)

@get('/album/<album_id>')
def album(album_id):

    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")
        
    if not check_user_exists(request.get_cookie("email", secret = secret)):
        redirect("/logout")

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()

    cursor.execute("UPDATE Albums SET hits = hits + 1 WHERE id = ?", [album_id])
    conn.commit()
    cursor.execute("SELECT album_name FROM Albums WHERE id = ?", [album_id])

    album_name = cursor.fetchone()[0]

    cursor.execute("SELECT * FROM Songs WHERE album_name = ?", [album_name])
    results = cursor.fetchall()

    if len(results) < 1:
        return error500(None)
    else:

        artist_id = get_artist_id(results[0][1])
        
        return template("album", songs=results, email=request.get_cookie("email", secret = secret), album_id = album_id, is_admin = check_admin(request.get_cookie("email", secret = secret)), is_confirmed = check_confirmed(request.get_cookie("email", secret = secret)), artist_id = artist_id)

@get('/artist/<artist_id>')
def artist(artist_id):
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")
        
    if not check_user_exists(request.get_cookie("email", secret = secret)):
        redirect("/logout")

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT artist_name FROM Artists WHERE id = ?", [artist_id])

    result = cursor.fetchone()
    
    if result is not None:
        artist_name = result[0]
        
        cursor.execute("SELECT id, album_name FROM Albums WHERE artist_name = ?", [artist_name])
        albums = cursor.fetchall()
        return template("artist", email = request.get_cookie("email", secret = secret), is_admin=check_admin(request.get_cookie("email", secret = secret)), albums = albums, artist = artist_name)
    else:
        redirect("/home")

@post('/auth')
def authenticate():
    global master_secret_key
    email = request.forms.get("email").lower()
    raw_password = request.forms.get("password")

    auth = authenticate_user(email, raw_password)

    if auth is None:
        redirect("/login/none")
    elif not auth:
        redirect("/login/auth")
    elif auth:
        response.set_cookie("email", email, secret = secret)
        redirect("/home")

@get('/signup')
def signup():
    if request.get_cookie("email", secret = secret) is not None:
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
    email = request.forms.get("email").lower()
    password = request.forms.get("password")
    confirm = request.forms.get("confirm_password")

    if not "." in email and not "@" in email:
        redirect("/signup/invalid")
    
    if (password == confirm):
        try:
            create_user(email, password, False)
            response.set_cookie("email", email, secret = secret)
            redirect("/home")
        except sqlite3.IntegrityError:
            redirect("/signup/dup")
    else:
        redirect("signup/mismatch")

@get('/home')
def home():
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")

    if not check_user_exists(request.get_cookie("email", secret = secret)):
        redirect("/logout")
        
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT DISTINCT id, album_name FROM Albums WHERE cover_art_file_path IS NOT NULL and cover_art_file_name IS NOT NULL ORDER BY RANDOM() LIMIT 6")
    random_albums = cursor.fetchall()
    cursor = conn.cursor()
    cursor.execute("SELECT id, album_name, artist_name, hits FROM Albums ORDER BY hits DESC LIMIT 10")
    top_albums = cursor.fetchall()
    cursor.execute("SELECT album_name, artist_name, id FROM Albums ORDER BY id DESC LIMIT 10")
    recent_albums = cursor.fetchall()

    conn.close()
    
    return template("home", email=request.get_cookie("email", secret = secret), album_art_ids=random_albums, top_albums=top_albums, recent_albums = recent_albums, is_admin=check_admin(request.get_cookie("email", secret = secret)))

@post('/search')
def search():
    if request.get_cookie("email", secret = secret) is None:
        redirect("/login")

    if not check_user_exists(request.get_cookie("email", secret = secret)):
        redirect("/logout")

    if len(request.forms.get("search_criteria")) <= 2:
        return template("search", songs = [], artists = [], albums = [], email = request.get_cookie("email", secret = secret), is_admin = check_admin(request.get_cookie("email", secret = secret)), error=True)

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Songs WHERE title LIKE '%" + " ".join(re.findall(r'\w+', request.forms.get("search_criteria").lower())) + "%'")
    song_results = cursor.fetchall()
    cursor.execute("SELECT * FROM Albums WHERE album_name LIKE '%" + " ".join(re.findall(r'\w+', request.forms.get("search_criteria").lower())) + "%'")
    album_results = cursor.fetchall()
    cursor.execute("SELECT * FROM Artists WHERE artist_name LIKE '%" + " ".join(re.findall(r'\w+', request.forms.get("search_criteria").lower())) + "%'")
    artist_results = cursor.fetchall()
    conn.close()

    return template("search", songs = song_results, artists = artist_results, albums = album_results, email = request.get_cookie("email", secret = secret), is_admin = check_admin(request.get_cookie("email", secret = secret)), error=False)

@post('/suggest')
def suggest():
    content = request.forms.get("content")
    email = request.get_cookie("email", secret = secret)

    if content is not "" and check_confirmed(email):
        conn = sqlite3.connect("db/data.db")
        cursor = conn.cursor()
        cursor.execute("INSERT INTO Suggestions (user_email, content) VALUES (?, ?)", [content, email])
        conn.commit()

    redirect("/home")

@get('/suggestions')
def get_suggestions():
    email = request.get_cookie("email", secret = secret)
    
    if email is None:
        redirect("/login")

    if not check_user_exists(email):
        redirect("/logout")

    if not check_admin(email):
        redirect("/home")

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()

    cursor.execute("SELECT user_email, content FROM Suggestions")
    suggestions = cursor.fetchall()
    return template("suggestions", suggestions = suggestions, email = email, is_admin = check_admin(email))


def get_album_id(album_name):
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    cursor.execute("SELECT id FROM Albums WHERE album_name = ?", [album_name])
    
    results = cursor.fetchone()

    conn.close()

    if results is not None:
        return results[0]
    else:
        return None
    

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
    
    cursor.execute("INSERT INTO Users (email, password_hash, password_salt, is_admin, is_confirmed) VALUES (?, ?, ?, ?, 0)", (email, hashed_password, salt, is_admin))
    conn.commit()
    conn.close()

def check_admin(email):
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()

    if email is None:
        return False
    
    cursor.execute("SELECT is_admin FROM Users WHERE email = ?", [email])

    result = cursor.fetchone()
    
    if result is not None and result[0] is not None:
        is_admin = result[0]
    else:
        return False

    conn.close()

    return is_admin == 1

def check_confirmed(email):
    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()

    if email is None:
        return False
    
    cursor.execute("SELECT is_confirmed FROM Users WHERE email = ?", [email])

    result = cursor.fetchone()

    if result is not None and result[0] is not None:
        is_confirmed = result[0]
    else:
        return False

    conn.close()

    return is_confirmed == 1

def check_user_exists(email):

    if email is None:
        return False

    conn = sqlite3.connect("db/data.db")
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM Users WHERE email = ?", [email])
    result = cursor.fetchone()

    conn.close()
    
    return not result is None

run(host="0.0.0.0", port=80, debug=False, server="gevent")
