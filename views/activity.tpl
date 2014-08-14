% include('header.tpl', email=email, is_admin=is_admin)
% import string
<br>
<br><br><br>
<br>

<div class="row">
  <div class="medium-10 columns">
  </div>
  <div class="medium-10 columns">
    <table>
      <thead>
	<tr>
	  <th>IP</th>
	  <th>Email</th>
	  <th>Song</th>
	  <th>Album</th>
	  <th>Art</th>
	</tr>
      </thead>
      <tbody>
	% for result in hits:
	<tr>
	  <td>{{result[0]}}</td>
	  <td>{{result[1]}}</td>
	  <td>{{string.capwords(result[2])}}</td>
	  <td><a href="/album/{{result[4]}}">{{string.capwords(result[3])}}</a></td>
	  <td><img width="150" height="150" src="/art/{{result[4]}}"></td>
	</tr>
	% end
      </tbody>
    </table>	 
  </div>
  <div class="medium-10 columns">
  </div>
</div>
