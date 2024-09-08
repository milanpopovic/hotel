<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/save_user" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">New User</div>
  <fieldset>
    <label for="room_no">Login</label>
    <input type="text" placeholder="login" id="login" name="login">
    <label for="password">Password</label>
    <input type="text" placeholder="password" id="password" name="password">
    <label for="floor">Status</label>
    <select id="status" name="status">
      <option value="active">active</option>
      <option value="blocked">blocked</option>
    </select>
    <input class="button-primary" type="submit" value="Send">
    <input type="button" value="Cancel" onclick="history.back()"/>
  </fieldset>
</form>
</div>
<script>
function validateForm(){
    return true;
}
</script>
