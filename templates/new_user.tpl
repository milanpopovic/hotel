<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/save_user" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">New User</div>
  <fieldset>
    <label for="room_no">Login</label>
    <input type="text" placeholder="login" id="login" name="login">
    <label for="password">Password</label>
    <input type="text" placeholder="password" id="password" name="password">
    <label for="email">Email</label>
    <input type="text" placeholder="email" id="email" name="email">
    <label for="phone">Mobile</label>
    <input type="text" placeholder="phone" id="phone" name="phone">
    <label for="administrator">Administrator?</label>
    <input type="checkbox" id="administrator" name="administrator" value='yes'>
    <label for="status">Status</label>
    <select id="status" name="status">
      <option value="active">active</option>
      <option value="blocked">blocked</option>
    </select>
    <input class="button-primary" type="submit" value="Save">
    <input type="button" value="Cancel" onclick="history.back()"/>
  </fieldset>
</form>
</div>
<script>
function validateForm(){
    return true;
}
</script>
