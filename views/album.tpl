<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">

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

	  <li>
	    <a href="#" class="button success" data-reveal-id="suggestions-modal" data-reveal>Suggest music</a>
	  </li>

	  <div id="suggestions-modal" class="reveal-modal small text-center" data-reveal>
	    <h3 class="subheader text-center">Want more music?</h3>

	    <form action="/suggest" method="post">
	      <br>
	      <p class="text-center">Make a request for the music you like. Include the artist and the album you want (or just all the music by a certain artist).</p>
	      <textarea name="content" placeholder="e.g. I want the album Babel by Mumford & Sons" style="margin-left: auto; max-width: 700px" ></textarea>


	      <button type="submit" class="button" style="margin: 0 auto;">Suggest</button>

	    </form>



	    <a class="close-reveal-modal">&#215;</a>
	  </div>


	</ul>
      </section>
    </nav>
    </div>

    <br>
    <br>



    <h4 class="subheader text-center">{{songs[0][1].title()}}</h4>

    <div class="row" data-equalizer>
      <div class="large-6 columns" data-equalizer-watch>
	<fieldset>

	  <legend> {{songs[0][3].title()}} </legend>
	  
	  <ul id="playlist" class="disc">
	    % for song in songs:
	    <li><a href="/song/{{song[0]}}">{{song[2].title()}}</a></li>
	    % end
	  </ul>

	</fieldset>
      </div>
      <div class="large-6 columns" data-equalizer-watch>
	<a class="th" href="">
	  <img src="/art/{{ album_id }}" style="width:500px;" />
	</a>

	<br>
	<br>

	<audio controls id="audio_player" style="margin-left: 5.9em;" preload="auto" controls="" tabindex="0">

	</audio>

	<br>
	<br>

	% if not is_confirmed:
	<div data-alert class="alert-box alert round">
	  Only confirmed users can enjoy the music. Get confirmed and try again.
	</div>
	% end
	
      </div>


    </div>


    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>
    <script>$(document).foundation();</script>

    <script language="javascript">

    var audio;
    var playlist;
    var tracks;
    var current;

    init();

    function init(){
        current = 0;
        audio = $('#audio_player');
        audio[0].volume = 0.5;
        audio[0].play();
        playlist = $('#playlist');

        tracks = playlist.find('li a');
        len = tracks.length - 1;

        playlist.find('a').click(function(e){
            e.preventDefault();
            link = $(this);
            current = link.parent().index();
            run(link, audio[0]);
        });

        audio[0].addEventListener('ended',function(e){
            current++;
            if(current == len){
                current = 0;
                link = playlist.find('a')[0];
            }else{
                link = playlist.find('a')[current];    
            }

            run($(link),audio[0]);
        });
    }

    function run(link, player){
        player.src = link.attr('href');
        par = link.parent();
	par.addClass('active').siblings().removeClass('active');
	audio[0].load();
	audio[0].play();
    }

    </script>


  </body>
</html>
