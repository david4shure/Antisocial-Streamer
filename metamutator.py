# ==================================

# David Shure
# This is a simple metadata editor
# for use with multiple files of 
# a certain type at a time

# ==================================

import eyeD3, os, fnmatch, mutagen
from mutagen.easyid3 import EasyID3

# find_files: string, string -> array<(string, string)>
# finds all files that match a certain pattern and returns
# an array of tuples where the first item in the tuple
# is the path, and the second is the filename
def find_files(directory, pattern):
    files_with_path = []
    for root, dirs, files in os.walk(directory):
        for basename in files:
            if fnmatch.fnmatch(basename, pattern):
                filename = os.path.join(root, basename)
                files_with_path.append([root, basename])

    return files_with_path

# edit_artist_metadata string, string, string -> None
# changes the artist field in metadata for all files
# matching the file_extension passed
def edit_artist_metadata(file_directory, file_extension, new_artist): # e.g. edit_metadata("~/Downloads/The Beatles", "*.mp3", "The Beatles")
    for file_tuple in find_files(file_directory, file_extension):
        song = EasyID3(file_tuple[0] + "/" + file_tuple[1])
        song["artist"] = new_artist
        song.save()
        print "Editing %s/%s" % (file_tuple[0], file_tuple[1])

# edit_album_metadata string, string, string -> None
# changes the album field in metadata for all files
# matching the file_extension passed
def edit_album_metadata(file_directory, file_extension, new_album):
    for file_tuple in find_files(file_directory, file_extension):
        song = EasyID3(file_tuple[0] + "/" + file_tuple[1])
        song["album"] = new_album
        song.save()
        print "Editing %s%s" % (file_tuple[0], file_tuple[1])

# edit_title_metadata string, string, string -> None
def edit_song_metadata(file_directory, file_name, new_title):
    song = EasyID3(file_directory + "/" + file_name)
    song["title"] = new_title
    song.save()
    print "Editing %s%s" % (file_directory, file_name)

# example usage
# edit_artist_metadata("/home/david/Downloads/Audiomachine - Tree of life", "*.mp3", "Audiomachine")
