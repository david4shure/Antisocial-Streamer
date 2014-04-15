% include('header.tpl', email=email, is_admin=is_admin)

  <br>
  <br>
  <br>


  <h4 class="subheader text-center">{{ artist.title() }}</h4>

  <br>
  <br>

  % for i in range(0, len(albums) - 1, 2):
  <div class="row" data-equalizer>
    <div class="large-5 columns">
      <a href="/album/{{albums[i][0]}}"><img src="/art/{{albums[i][0]}}" width="500" height="500" /></a>
      <h6 class="subheader text-center">{{ albums[i][1].title() }}</h6>
    </div>
    
    % if not i >= len(albums):
    <div class="large-5 columns">
      <a href="/album/{{albums[i+1][0]}}"><img src="/art/{{albums[i + 1][0]}}" width="500" height="500" /></a>
      <h6 class="subheader text-center">{{ albums[i + 1][1].title() }}</h6>
    </div>
    % end
  </div>

  <br>
  <br>
  <br>

  
  % end
  
  <br>

  % if len(albums) % 2 == 1:
  <div class="row" data-equalizer>
    <div class="large-5 columns">
      <a href="/album/{{albums[-1][0]}}"><img src="/art/{{albums[-1][0]}}" width="400" height="400" /></a>
      <h6 class="subheader text-center">{{ albums[-1][1].title() }}</h6>
    </div>
  </div>
  % end

  
  <br>
  <br>
  
  % end
