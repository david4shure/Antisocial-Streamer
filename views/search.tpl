<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
    <div class="fixed">
    <nav class="top-bar" data-topbar>

      <ul class="title-area">
	<li class="name">
	  <h1><a href="/home">Antisocial Streamer</a></h1>
	</li>
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
    </div>

    <h4 class="subheader text-center">Search Results</h4>


    <fieldset>
      <legend>Songs</legend>
      % if len(songs) == 0:
      <h6>There are no matching songs</h6>
      % end
      % for song in songs:
      <div class="row">
	  <a href="/song/{{ song[0] }}">{{ song[2].title() }}</a> by {{ song[1].title() }} on {{ song[3].title() }}
      </div>
      % end
    </fieldset>

    <fieldset>
      <legend>Albums</legend>
      % if len(albums) == 0:
      <h6>There are no matching albums</h6>
      % end
      % for album in albums:
      <div class="row">
	<a href="/album/{{album[0]}}">{{ album[1].title() }}</a>
      </div>
      % end
    </fieldset>


    <fieldset>
      <legend>Artists</legend>
      % if len(artists) == 0:
      <h6>There are no matching artists</h6>
      % end
      % for artist in artists:
      <div class="row">
	{{ artist[1].title() }}
      </div>
      % end
    </fieldset>

    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>


    <script>$(document).foundation();</script>


  </body>
</html>
