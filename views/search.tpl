<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/static/foundation.min.js"></scirpt>
    <script type="text/javascript" src="/static/foundation.orbit.js"></script>
  </head>
  
  <body>

    <nav class="top-bar" data-topbar>

      <ul class="title-area">
	<li class="name">
	  <h1><a href="/home">Antisocial Streamer</a></h1>
	</li>
      </ul>
      
      <section class="top-bar-section">
	<!-- Right Nav Section -->
	<ul class="right">
	  
	  <li><a href="#">{{ email }}</a></li>
	  <li class="active"><a href="/logout">Logout</a></li>
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

    <h4 class="subheader text-center">Search Results</h4>


    <div class="panel">
      % for song in songs:
      <div class="row">
	<div class="large-6 small-3 columns">
	  <a href="/song/{{ song[0] }}">{{ song[2] }}</a> by {{ song[1] }} on {{ song[3] }}
	</div>
      </div>
      % end
    </div>

    <div class="panel">
      % for album in albums:
      <div class="row">
	<a href="/album/{{album[0]}}">{{ album[1] }}</a>
      </div>
      % end
    </div>


    <div class="panel">
      % for artist in artists:
      <div class="row">
	{{ artist[1] }}
      </div>
      % end
    </div>

    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>


    <script>$(document).foundation();</script>


  </body>
</html>
