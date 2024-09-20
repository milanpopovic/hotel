<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/save_device" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">New Device</div>
  <fieldset>
    <label for="name">Name</label>
    <input type="text" placeholder="name" id="name" name="name">
    <label for="ip">IP address</label>
    <input type="text" placeholder="ip" id="ip" name="ip">
    <label for="floor">Status</label>
    <select id="status" name="status">
      <option value="ON">ON</option>
      <option value="OFF">OFF</option>
    </select>
    <div style="padding-bottom: 18px;">Comment<br/>
        <textarea id="comment" false name="comment"  style="max-width : 450px;height: auto;" rows="8" class="form-control"></textarea>
    </div>
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
