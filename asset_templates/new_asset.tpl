<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/save_asset" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">New Room</div>
  <fieldset>
    <label for="name">Name</label>
    <input type="text" placeholder="name" id="name" name="name">
    <label for="location">Location</label>
    <input type="text" placeholder="location" id="location" name="location">
    <label for='category'>Category</label>
    <select id="category" name="category">
      <option value="Room mobillar">Room mobillar</option>
      <option value="Equipment">Equipment</option>
    </select>
    <label for="year">Year</label>
    <input type="text" placeholder="year" id="year" name="year">
    <label for="status">Status</label>
    <select id="status" name="status">
      <option value="In use">In use</option>
      <option value="Repairing">Repairing</option>
      <option value="Out of duty">Out of duty</option>
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
