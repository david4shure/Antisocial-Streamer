<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">

  </head>
  
  <body>
    <script language="javascript">
      function playSong(song_url) {
          var player = document.getElementById("audio_player");
          var source = document.getElementById("audio_source");

          player.pause();
          source.src = song_url;
          source.currentTime = 0;

          player.load();
          player.play()
      }
    </script>

    <nav class="top-bar" data-topbar>
      <ul class="title-area">
	<li class="name">
	  <h1><a href="/home">Antisocial Streamer</a></h1>
	</li>
	<li class="toggle-topbar menu-icon"><a href="#">Menu</a></li>
      </ul>
      
      <section class="top-bar-section">
	<!-- Right Nav Section -->
	<ul class="right">

	  <li class="active"><a href="/logout">Logout</a></li>
	  % if is_admin:
	  <li class="has-dropdown">
	    <a href="#">{{ email }}</a>
	    <ul class="dropdown">
	      <li><a href="/manage">Manage Users</a></li>
	    </ul>
	  </li>
	  % else:
	  <li><a href="#">{{ email }}</a></li>
	  % end

	</ul>
	
	<!-- Left Nav Section -->
	<ul class="left">
	  <li class="has-form">

	    <form action="/search" method="post">
	      <div class="row collapse">
		<div class="large-8 small-9 columns">
		  <input type="text" placeholder="Find media" name="search_criteria">
		</div>
		<div class="large-4 small-3 columns">
		  <button type="submit" class="alert button expand">Search</button>
		</div>
	      </div>
	    </form>
	    
	  </li>

	</ul>
      </section>
    </nav>

    <br>
    <br>



    <h4 class="subheader text-center">{{songs[0][1].title()}}</h4>
    <div class="row" data-equalizer>
      <div class="large-6 columns" data-equalizer-watch>
	<fieldset>
	  <legend> {{songs[0][3].title()}} </legend>
	  
	  <ul class="disc">
	    % for song in songs:
	    <li><strong><i><a OnClick="playSong('/song/{{ song[0] }}')">{{song[2].title()}}</a></i></strong></li>
	    % end
	  </ul>

	  <audio controls id="audio_player">
	    <source src="/song/{{songs[0][0]}}" type="audio/mpeg" id="audio_source">
	  </audio>
	</fieldset>
      </div>
      <div class="large-6 columns" data-equalizer-watch>
	<a class="th" href="/album/{{ album_id }}">
	  <img src="/art/{{ album_id }}" style="width:500px;height:500px;" />
	</a>
      </div>
    </div>

    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>
    <script>$(document).foundation();</script>

  </body>
</html>
