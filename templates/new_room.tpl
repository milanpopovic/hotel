<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/save_room" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">New Room</div>
  <fieldset>
    <label for="room_no">Room Number</label>
    <input type="text" placeholder="Room number" id="room_no" name="room_no">
    <label for="floor">Floor</label>
    <select id="floor" name="floor">
      <option value="0">0</option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
    </select>
    <label for='category'>Category</label>
    <select id="category" name="category">
      <option value="Apartment">Apartment</option>
      <option value="Regular room">Regular room</option>
      <option value="Luxury apartment">Luxury apartment</option>
      <option value="Luxury room">Luxury room</option>
    </select>
    <label for="beds">No. of beds</label>
    <input type="text" placeholder="No. of beds" id="beds" name="beds">
    <label for="price">Price per day</label>
    <input placeholder="price per day" id="price" name="price"></input>
    <label for="status">Status</label>
    <select id="status" name="status">
      <option value="Vacant">Vacant</option>
      <option value="Occupied">Occupied</option>
      <option value="Cleaning">Cleaning</option>
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
