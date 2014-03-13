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

	</ul>
      </section>
    </nav>

    <div class="row">
      <h4 class="subheader text-center">Some Recomendations</h4>
    </div>

    <div class="panel">
      % for album_id in album_art_ids:
      
      <a class="th" href="/album/{{ album_id[0] }}">
	<img src="/art/{{ album_id[0] }}" width="300" height="300">
      </a>
      
      % end
      <div class="row">
	
      </div>
    </div>


    <!-- <div class="panel"> -->
    <!--   <div class="row"> -->
    <!-- 	<div class="large-20 columns"> -->
    <!-- 	  Some Assorted Albums -->
    <!-- 	</div> -->
    <!--   </div> -->
    <!-- </div> -->

  </body>
</html>
