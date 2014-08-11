% include('header.tpl', email=email, is_admin=is_admin)

  <br>
  <br>
  <br>
  
<form method="POST" enctype="multipart/form-data" action="/modify/album/{{album_id}}">
  <input type=file accept="image/*" name="image_file">
  <input type="submit" value="add">
</form>
