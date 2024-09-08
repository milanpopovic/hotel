<link rel="stylesheet" href="../static/css/milligram.min.css" />

<div class="container">
<form method="post" action="/update_user" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">View/Edit User</div>
  <fieldset>
    <div style="display:none">
    <input type="text" id="rowid" name="rowid" value={{rowid}} style="max-width : 450px;" class="form-control"/>
    </div>
    <label for="room_no">Login</label>
    <input type="text" placeholder="login" id="login" name="login" value={{login}}>
    <label for="password">Password</label>
    <input type="password" placeholder="password" id="password" name="password" value={{password}}>
    <label for="status">Status</label>
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

function selectElement(id, valueToSelect) {    
    let element = document.getElementById(id);
    element.value = valueToSelect;
}
selectElement('status', '{{status}}');
</script>

