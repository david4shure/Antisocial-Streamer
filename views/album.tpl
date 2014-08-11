% include('header.tpl', email=email, is_admin=is_admin)
% from helpers import *



    <br>
    <br>

    <a href="/artist/{{ artist_id }}"><h4 class="subheader text-center">{{songs[0][1].title()}}</h4></a>



    <div class="row" data-equalizer>
      <div class="large-6 columns" data-equalizer-watch>
	<fieldset>

	  <legend> {{songs[0][3].title()}} </legend>
	  
	  <ul id="playlist" class="disc">
	    % for song in songs:
	    <li><a href="/song/{{song[0]}}">{{song[2].title()}}</a></li>
	    % end
	  </ul>

	  % if is_admin:
	  <a href="/modify/album/{{album_id}}">Change album art</a>
	  % end 

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
