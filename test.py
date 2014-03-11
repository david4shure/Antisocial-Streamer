import os, fnmatch, eyeD3


def find_files(directory, pattern):
    files_with_path = []
    for root, dirs, files in os.walk(directory):
        for basename in files:
            if fnmatch.fnmatch(basename, pattern):
                filename = os.path.join(root, basename)
                files_with_path.append([root, basename])

    return files_with_path

for item in find_files(os.path.expanduser("~/"), '*.mp3'):
    print "Directory: " + item[0] + " Filename: " + item[1]

