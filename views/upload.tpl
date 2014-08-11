<<<<<<< Updated upstream
% include('header.tpl', email=email, is_admin = is_admin)

<br><br><br><br>

<form method="POST" enctype="multipart/form-data" action="/upload">
   <input type="file" name="upload" multiple="">
   <input type="submit" value="add">
=======
<form method="POST" enctype="multipart/form-data" action="/upload">
  <input type="file" name="file[]" multiple="">
  <input type="submit" value="add">
>>>>>>> Stashed changes
</form>
