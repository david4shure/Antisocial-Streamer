import sqlite3, os, fnmatch, eyeD3

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

        try:
            cursor.execute("INSERT INTO Artists (artist_name) VALUES (?)", [artist.lower()])
            conn.commit()
        except sqlite3.IntegrityError:
            print "! Artist Integrity Error !"
        except sqlite3.ProgrammingError:
            print "! Album Programming Error !"
        
        try:
            cover_art = find_files(item[0], "*.jpg")

            params_array = [album.lower(), artist.lower()]
            if len(cover_art) >= 1:
                print str(cover_art[0][0]) + "/" + str(cover_art[0][1])
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
                
            if len(params_array[0]) > 1 and len(params_array[1]) > 1:
                cursor.execute("INSERT INTO Albums (album_name, artist_name, cover_art_file_path, cover_art_file_name, release_year, genre) VALUES (?, ?, ?, ?, ?, ?)", params_array)
                conn.commit()
                print "Inserted the following: " + str(params_array)
        except sqlite3.IntegrityError:
            print "! Album Integrity Error !"

        try:
            if album and artist and track:
                params_array = []

                params_array.append(artist.lower())
                params_array.append(track.lower())
                params_array.append(album.lower())

                params_array.append(item[0])
                params_array.append(item[1])

                year = tag.getYear()

                if year:
                    params_array.append(year)
                else:
                    params_array.append(None)
                    
                cursor.execute("INSERT INTO Songs (artist_name, title, album_name, file_path, file_name, release_year) VALUES (?, ?, ?, ?, ?, ?)", params_array)
                conn.commit()
        except sqlite3.IntegrityError:
            print "! Song Integrity Error !"
        except sqlite3.ProgrammingError:
            print "! Song Programming Error !"

        conn.commit()
        
    conn.close()

populate_db("/home/david/Downloads/Queen - A Night At The Opera [smb]/", "*.mp3")
