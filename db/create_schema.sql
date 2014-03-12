CREATE TABLE Users (
       email varchar(40) PRIMARY KEY,
       password_hash varchar(100),
       password_salt varchar(100),
       is_admin BOOLEAN
);

CREATE TABLE Songs (
       id integer PRIMARY KEY,
       artist_name varchar(100),
       title varchar(100),
       album_name varchar(100),
       file_path varchar(200),
       file_name varchar(200),
       UNIQUE (artist_name, title, album_name),
       FOREIGN KEY (artist_name) REFERENCES Artists (artist_name),
       FOREIGN KEY (album_name) REFERENCES Albums (album_name)
);

CREATE TABLE Artists (
       id integer PRIMARY KEY,
       artist_name varchar(100) UNIQUE
);

CREATE TABLE Albums (
       id integer PRIMARY KEY,
       album_name varchar(100),
       artist_name varchar(100),
       cover_art_file varchar(100),
       UNIQUE (album_name, artist_name),
       FOREIGN KEY (artist_name) REFERENCES Artists (artist_name)
);
