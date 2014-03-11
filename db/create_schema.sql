CREATE TABLE Users (
       email varchar(40) PRIMARY KEY,
       password_hash varchar(100),
       password_salt varchar(100),
       is_admin BOOLEAN
);

CREATE TABLE Songs (
       artist varchar(100),
       title varchar(100),
       album varchar(100),
       file_path varchar(200),
       file_name varchar(200),
       PRIMARY KEY (artist, title, album)
);
