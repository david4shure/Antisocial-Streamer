% include('header.tpl', email=email, is_admin=is_admin)
% from helpers import get_album_id

    <h4 class="subheader text-center">Search Results</h4>


    <fieldset>
      <legend>Songs</legend>
      % if len(songs) == 0:
      <h6>There are no matching songs</h6>
      % end
      % for song in songs:
      <div class="row">
	  <a href="/song/{{ song[0] }}">{{ song[2].title() }}</a> by {{ song[1].title() }} on <a href="/album/{{ get_album_id(song[3]) }}">{{ song[3].title() }}</a>
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
