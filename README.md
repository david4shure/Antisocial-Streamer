Antisocial-Streamer
===================

An invite only web application for your MP3 music library with rendered album art

![alt tag](http://i1306.photobucket.com/albums/s570/david4shure/streamer_zps7f8a29ea.png)
![alt tag](http://i1306.photobucket.com/albums/s570/david4shure/request_zps1086c497.png)


Dependencies
============

Make sure you have python-sqlite3, python-eyeD3, python-bcrypt, python-gevent, python-mutagen installed.
  To install run 
```shell
sudo apt-get install python-sqlite python-eyeD3 python-bcrypt python-gevent python-mutagen
```

Running the application
=======================
To populate the db of all your music and cover art, simply edit populate_database.py,
and add the directory you want it to scan. Then run

```shell
python populate_database.py
```


Once you have installed all of the requirements, simple run 
```shell
sudo python streamer.py
```

And enjoy your MP3 library in all of its glory from anywhere!

Features
========
1. Beautiful web interface for your MP3 music library
2. Search through your library
3. Play entire albums at a time, also indexes and renders album art
4. Search through your library on keywords
5. Users can only listen to your music if they are confirmed (by you)!
6. Users can suggest music that they want.
7. Dedicated artist pages where you look through all their albums

Upcoming
========

1. Admin users can edit metadata on albums, songs artists if incorrect or inaccurate (Future)
2. Eventual support for FLAC, OGG and M4A files (Future)
