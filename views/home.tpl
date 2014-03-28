<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
    <!-- <script type="text/javascript" src="/static/foundation.min.js"></scirpt> -->
    <!-- <script type="text/javascript" src="/static/foundation.orbit.js"></script> -->
  </head>
  
  <body>

    <script type="text/javascript">

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-49489019-1']);
      _gaq.push(['_trackPageview']);
      
      (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
  
    </script>

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
    
    <div class="row">
      <h4 class="subheader text-center">Random Picks</h4>
    </div>
    <div class="panel clearfix">
      % i = 0
      % for album_id in album_art_ids:
	<a href="/album/{{ album_id[0] }}" >
	  <img src="/art/{{ album_id[0] }}" width="16.3%" href="/album/{{ album_id[0] }}" style="padding: 5px; min-width: 150px;" id="picture_{{i}}">
	</a>
	% i += 1
      % end
    </div>

    <div class="small-1 columns">
      <br>
    </div>

  <div class="large-6 columns" style="margin-left: 2em;">
    <legend style="margin-bottom:1em;">Top songs</legend>
    <table>
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
  </div>

  <div class="small-4 columns" style="margin-right: -5em;">
    <legend style="margin-bottom:1em;">New additions</legend>
    <table>
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
  </div>

    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>

    <script>

      for(var i = 0; i < 6; i++) {
	var picture = document.getElementById("picture_" + i);
	picture.style.height = picture.clientWidth;
      }

      window.onresize=function() {
	for(var i = 0; i < 6; i++) {
	    var picture = document.getElementById("picture_" + i);
	    picture.style.height = picture.clientWidth;
        }
      };

    </script>

    <script>$(document).foundation();</script>
    


  </body>
</html>
