<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/js/jquery.jplayer.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function(){
      $("#jquery_jplayer_1").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4a: "http://www.jplayer.org/audio/m4a/Miaow-07-Bubble.m4a",
            oga: "http://www.jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
          });
        },
        swfPath: "/js",
        supplied: "m4a, oga"
      });
    });
    </script>


  </head>
  
  <body>

    <nav class="top-bar" data-topbar>
      <ul class="title-area">
	<li class="name">
	  <h1><a href="#">Antisocial Streamer</a></h1>
	</li>
	<li class="toggle-topbar menu-icon"><a href="#">Menu</a></li>
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

    <video controls autoplay name="media">
      <source src="http://localhost:8080/play/song/1" type="audio/mpeg">
    </video>
    
  </body>
</html>
