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
	  <th>Email</th>
	  <th>Suggestion</th>
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
</body>

