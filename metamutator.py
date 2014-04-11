import eyeD3, os, fnmatch, mutagen
from mutagen.easyid3 import EasyID3

def find_files(directory, pattern):
    files_with_path = []
    for root, dirs, files in os.walk(directory):
        for basename in files:
            if fnmatch.fnmatch(basename, pattern):
                filename = os.path.join(root, basename)
                files_with_path.append([root, basename])

    return files_with_path

def edit_artist_metadata(file_directory, file_extension, new_artist): # e.g. edit_metadata("~/Downloads/The Beatles/", "*.mp3", "The Beatles")
    for file_tuple in find_files(file_directory, file_extension):
        audio = EasyID3(file_tuple[0] + "/" + file_tuple[1])
        audio["artist"] = new_artist
        audio.save()
        print "Editing %s/%s" % (file_tuple[0], file_tuple[1])

edit_artist_metadata("/home/david/Downloads/Audiomachine - Tree of life", "*.mp3", "Audiomachine")
