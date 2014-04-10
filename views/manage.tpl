% include('header.tpl', email=email, is_admin=is_admin)

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
