import bcrypt, json, sqlite3
from bottle import *

master_secret_key = ""

with open("keys", "r") as keys:
    master_secret_key = keys.read()

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
    
run(host="0.0.0.0", port=8080, debug=True)
