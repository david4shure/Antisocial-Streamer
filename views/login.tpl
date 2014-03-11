<html>
  <head>
    <title>Login In : Antisocial Streamer</title>
    <link href="/static/foundation.min.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
    
    <div class="text-center">
      <div class="show-for-large-up" style="height:100px"></div>
      <form action="/auth" method="post">
        <div class="row">
          <div class="small-12 medium-4 columns medium-offset-4 radius panel">
            <h1>Antisocial Streamer</h1>
            <fieldset>
              <legend>Log In</legend>
              <input type="text" name="email" placeholder="Email"/>
              <input type="password" name="password" placeholder="Password"/>
              <button type="submit" class="small button">Login</button>
              % if error == "auth":
              <div data-alert class="alert-box alert">
                Invalid Login
              </div>
	      % end
	      % if error == "none":
	      <div data=alert class="alert-box alert">
		There is no user with that email. Try signing up.
	      </div>
              % end
            </fieldset>
          </div>
        </div>
      </form>
    </div>
    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>
    <script>$(document).foundation();</script>

  </body>

</html>
