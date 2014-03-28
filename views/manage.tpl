<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
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

	  <li><a href="/manage">{{ email }}</a></li>

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

    % if len(unconfirmed_users) > 0:
    <div class="small-4 columns">
      <table>
	<thead>
	  <tr>
	    <th>Email</th>
	    <th>Action</th>
	  </tr>
	</thead>
	<tbody>
	  % for user in unconfirmed_users:
	  <tr>
	    <form action="/confirm" method="POST">
	      <td>{{ user[0] }}<input type="text" value="{{ user[0] }}" name="confirm_user" style="visibility:hidden;"></td>
	      <td><button class="tiny button" style="top:-1.1em;">Confirm User</button></td>
	    </form>
	  </tr>
	  % end
	</tbody>
      </table>
    </div>
    % else:
    
    <div class="small-4 columns panel">
      <h3 class="text-centered">There are no unconfirmed users.</h3>
    </div>
    % end




    % if len(confirmed_users) > 0:
    <div class="small-4 columns">
      <table>
	<thead>
	  <tr>
	    <th>Email</th>
	    <th>Action</th>
	  </tr>
	</thead>
	<tbody>
	  % for user in confirmed_users:
	  <tr>
	    <form action="/bestow" method="POST">
	      <td>{{ user[0] }}<input type="text" value="{{ user[0] }}" name="make_admin" style="visibility:hidden;"></td>
	      <td><button class="tiny button" style="top:-1.1em;">Grant admin status</button></td>
	    </form>
	  </tr>
	  % end
	</tbody>
      </table>
    </div>
    % else:
    <div class="small-4 columns panel">
      <h3 class="text-centered">There are no non-admin users besides yourself.</h3>
    </div>
    % end


    % if len(confirmed_users) > 0:
    <div class="small-4 columns">
      <table>
	<thead>
	  <tr>
	    <th>Email</th>
	    <th>Action</th>
	  </tr>
	</thead>
	<tbody>
	  % for user in confirmed_users:
	  <tr>
	    <form action="/exile" method="POST">
	      <td>{{ user[0] }}<input type="text" value="{{ user[0] }}" name="exile_user" style="visibility:hidden;"></td>
	      <td><button class="tiny button" style="top:-1.1em;">Exile user</button></td>
	    </form>
	  </tr>
	  % end
	</tbody>
      </table>
    </div>
    % else:
    <div class="small-4 columns panel">
      <h3 class="text-centered">There are no other confirmed users.</h3>
    </div>
    % end
 

    
    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>

    <script>$(document).foundation();</script>


  </body>
</html>
