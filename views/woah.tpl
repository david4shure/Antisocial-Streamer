<html>
  <head>
    <title>Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
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

    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    
    <div class="small-4 columns">
      <div class="row">
	<br>
      </div>
    </div>

    <div class="small-4 columns text-center">
      <div class="panel">
      <h4 class="subheader text-center">Woah. Did I say you could listen to my music?</h4>
      <br>
      <h3 class="text-center"><small>You're unconfirmed.<small></h3>
      </div>
    </div>

    <div class="small-4 columns">
      <div class="row">
	<br>
      </div>
    </div>

    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>

    <script>$(document).foundation();</script>


  </body>
</html>
