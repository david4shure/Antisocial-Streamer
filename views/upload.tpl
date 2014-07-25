% include('header.tpl', email=email, is_admin=is_admin)

<form action="/upload" method="post" enctype="multipart/form-data">
      Category:      <input type="text" name="category">
      Select a file: <input type="file" name="upload">
      <input type="submit" value="Start upload">
</form>