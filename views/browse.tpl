% include("header.tpl", email = email, is_admin = is_admin)

<br>
<br>
<br>

%import sqlite3
%def get_album_name(album_id):
%    conn = sqlite3.connect("db/data.db")
%    cursor = conn.cursor()
%    cursor.execute("SELECT album_name FROM Albums WHERE id = ?", [album_id])
%    
%    results = cursor.fetchone()
%    
%    conn.close()
%
%    if results is None:
%        return None
%    else:
%        return results[0]
%    end
% end

% for genre in genre_pairs.keys():
  <h3>{{ genre }}</h3>
        <div class="content">
	  % for id in genre_pairs[genre]:
	      <a href="/album/{{id}}"><img src="/art/{{id}}" width=150 height=150></img></a>
  	  % end
        </div>
% end





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
