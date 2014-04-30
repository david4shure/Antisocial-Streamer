% include("header", email=email, is_admin=is_admin)

<br>
<br>
<br>
<br>

% if len(suggestions) > 0:
<div class="row">   
  <div class="twelve columns text-center">	      
    <table>	      
      <thead>
	<tr>
	  <th>Suggestion</th>
	  <th>Email</th>
	</tr>
      </thead>
      <tbody>
	% for s in suggestions:
	<tr>	       
	  <td>{{s[0]}}</td>
	  <td>{{s[1]}}</td>
	</tr>
	% end
      </tbody>
    </table>

    % else:
    <h4 class="subheader">There are no suggestions</h4>
    % end
    </div>

    <script src="/static/jquery.js"></script>
    <script src="/static/foundation.min.js"></script>
    
    <script>$(document).foundation();</script>
	

</body>
