CREATE TABLE Users (
       email varchar(40) PRIMARY KEY,
       password_hash varchar(100) NOT NULL,
       password_salt varchar(100) NOT NULL,
       is_admin BOOLEAN,
       is_confirmed BOOLEAN
);

CREATE TABLE Songs (
       id integer PRIMARY KEY,
       artist_name TEXT(100) NOT NULL,
       title TEXT(100) NOT NULL,
       album_name TEXT(100) NOT NULL,
       release_year TEXT(5),
       file_path TEXT(200) NOT NULL,
       file_name TEXT(200) NOT NULL,
       hits integer DEFAULT 0,
       UNIQUE(title, album_name, artist_name),
       FOREIGN KEY (artist_name) REFERENCES Artists (artist_name),
       FOREIGN KEY (album_name, release_year) REFERENCES Albums (album_name, release_year)
);

CREATE TABLE Artists (
       id integer PRIMARY KEY,
       artist_name TEXT(100) NOT NULL UNIQUE
);

CREATE TABLE Albums (
       id integer PRIMARY KEY,
       album_name TEXT(100) NOT NULL,
       artist_name TEXT(100) NOT NULL,
       cover_art_file_path TEXT(100),
       cover_art_file_name TEXT(100),
       release_year TEXT(5),
       genre TEXT(50),
       hits integer DEFAULT 0,
       UNIQUE(album_name, artist_name),
       FOREIGN KEY (artist_name) REFERENCES Artists (artist_name)
);

CREATE TABLE Suggestions (
       id integer PRIMARY KEY,
       content TEXT(500) NOT NULL,
       user_email varchar(100) NOT NULL
);

CREATE TABLE Hits (
      id integer PRIMARY KEY,
      ip TEXT(15) NOT NULL,
      email varchar(40) NOT NULL,
      song_id integer NOT NULL,
      FOREIGN KEY (email) REFERENCES Users (email),
      FOREIGN KEY (song_id) REFERENCES Songs (id)
);
