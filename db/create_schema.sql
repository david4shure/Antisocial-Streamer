CREATE TABLE Users (
       email varchar(40) PRIMARY KEY,
       password_hash varchar(100),
       password_salt varchar(100),
       is_admin BOOLEAN
);
