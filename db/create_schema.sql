CREATE TABLE Users (
       email varchar(40) PRIMARY KEY,
       password_hash varchar(100) NOT NULL,
       password_salt varchar(100) NOT NULL,
       is_admin BOOLEAN
);

CREATE TABLE Songs (
       id integer PRIMARY KEY,
       artist_name TEXT(100) NOT NULL,
       title TEXT(100) NOT NULL,
       album_name TEXT(100) NOT NULL,
       release_year TEXT(5),
       file_path TEXT(200) NOT NULL,
       file_name TEXT(200) NOT NULL,
       UNIQUE (artist_name, title, album_name),
       FOREIGN KEY (artist_name) REFERENCES Artists (artist_name),
       FOREIGN KEY (album_name, release_year) REFERENCES Albums (album_name, release_year)
);

CREATE TABLE Artists (
       id integer PRIMARY KEY,
       artist_name TEXT(100) UNIQUE NOT NULL
);

CREATE TABLE Albums (
       id integer PRIMARY KEY,
       album_name TEXT(100) NOT NULL,
       artist_name TEXT(100) NOT NULL,
       cover_art_file_path TEXT(100),
       cover_art_file_name TEXT(100),
       release_year TEXT(5),
       genre TEXT(50),
       UNIQUE (album_name, release_year),
       FOREIGN KEY (artist_name) REFERENCES Artists (artist_name)
);
