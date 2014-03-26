<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
    <!-- <script type="text/javascript" src="/static/foundation.min.js"></scirpt> -->
    <!-- <script type="text/javascript" src="/static/foundation.orbit.js"></script> -->
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

    <div class="row">
      <h4 class="subheader text-center">Random Picks</h4>
    </div>
    <div class="panel">
      % for album_id in album_art_ids:
	<a class="th" href="/album/{{ album_id[0] }}">
	  <img src="/art/{{ album_id[0] }}" style="width:297px;height:297px;">
	</a>
      % end
    </div>

    <div class="panel radius">

    <div class="row">
      <h4 class="subheader" style="margin-left:-5em;">Popular Tracks</h4>
    </div>

    <table style="float:left;margin-left:3em;">
      <thead>
	<tr>
	  <th>Title</th>
	  <th>Album</th>
	  <th>Artist</th>
	  <th>Hits</th>
	</tr>
      </thead>
      <tbody>
	% for song in top_songs:
	<tr>
	  <td><a href="/song/{{song[4]}}">{{ song[0].title() }}</a></td>
	  <td><a href="/album/{{song[5]}}">{{ song[1].title() }}</a></td>
	  <td><i>{{ song[3].title() }}</i></td>
	  <td>{{ song[2] }}</td>
	</tr>
	% end
      </tbody>
    </table>


    <h4 class="subheader" style="margin-top:-1.6em; margin-left: 56em;">Recently added albums</h4>

    <table style="float:right; margin-top:-.3em; margin-right:16em;">
      <thead>
	<tr>
	  <th>Album</th>
	  <th>Artist</th>
	</tr>
      </thead>
      <tbody>
	% for album in recent_albums:
	<tr>
	  <td><a href="/album/{{album[2]}}">{{ album[0].title() }}</a></td>
	  <td>{{ album[1].title() }}</td>
	</tr>
	% end
      </tbody>
    </table>
    

    <br>    <br>    <br>    <br>    <br>    <br>    <br>    <br>    <br>    <br>
    <br>    <br>    <br>    <br>    <br>    <br>    <br>    <br>    <br>    <br>
    <br>    <br>    <br>    <br>    <br>    <br>
    </div>
    
    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>

    <script>$(document).foundation();</script>


  </body>
</html>
