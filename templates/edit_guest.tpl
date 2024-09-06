<link rel="stylesheet" href="../static/css/milligram.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/pikaday.min.js" type="text/javascript"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/css/pikaday.min.css" rel="stylesheet" type="text/css" />
<div class="container">
<form method="post" action="/update_guest" onSubmit="return validateForm();">
<div class="container">
        <div class='row'>
            <div class='column' column-50">
                  <div style="display:none">
                  <input type="text" id="rowid" name="rowid" value={{rowid}} style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div>
                      <label for="status">Status</label>
                      <select id="status" name="status">
                        <option value="Checked-in">Checked-in</option>
                        <option value="Checked-out">Checked-out</option>
                        <option value="Reservation">Reservation</option>
                      </select>
                  </div>
                  <div style=" margin-left: 0; margin-right: 1%; width: 49%;">Room number<span style="color:red;"> *</span><br/>
	                  <input type="text" id="room_no" name="room_no" value={{room_no}} style="max-width: 30%;" class="form-control"/>
                  </div>
                  
                  <div style="display: flex; padding-bottom: 18px;max-width : 450px;">
	                  <div style=" margin-left: 0; margin-right: 1%; width: 49%;">First name<span style="color: red;"> *</span><br/>
		                  <input type="text" id="first_name" name="first_name" value={{first_name}} style="max-width: 100%;" class="form-control"/>
	                  </div>
	                  <div style=" margin-left: 1%; margin-right: 0; width: 49%;">Last name<span style="color: red;"> *</span><br/>
		                  <input type="text" id="last_name" name="last_name" value={{last_name}} style="max-width: 100%;" class="form-control"/>
	                  </div>
                  </div>
                  <div style="padding-bottom: 18px;">Arrival date<span style="color: red;"> *</span><br/>
                  <input type="text" id="arrival_date" name="arrival_date" value="{{arrival_date}}" style="max-width : 250px;" class="form-control"/>
                  </div>
                  <script type="text/javascript">new Pikaday({ field: document.getElementById('arrival_date') });</script>
                  <div style="padding-bottom: 18px;">Departure date<span style="color: red;"> *</span><br/>
                  <input type="text" id="departure_date" name="departure_date" value="{{departure_date}}" style="max-width : 250px;" class="form-control"/>
                  </div>
                  <script type="text/javascript">new Pikaday({ field: document.getElementById('departure_date') });</script>
                  <div style="padding-bottom: 18px;">Number of adults<span style="color: red;"> *</span><br/>
                  <input type="number" id="no_adults" name="no_adults" value={{no_adults}} style="max-width : 250px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;">Number of children<br/>
                  <input type="number" id="no_children" name="no_children" value={{no_children}} style="max-width : 250px;" class="form-control"/>
                  </div>
              </div>
              <div class='column'column-50" >
                  <div style="padding-bottom: 18px;">City<span style="color: red;"> *</span><br/>
                  <input type="text" id="city" name="city" value="{{city}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;">Address<span style="color: red;"> *</span><br/>
                  <input type="text" id="address" name="address" value="{{address}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;">Country<span style="color: red;"> *</span><br/>
                  <input type="text" id="country" name="country" value="{{country}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;">Phone<span style="color: red;"> *</span><br/>
                  <input type="text" id="phone" name="phone" value="{{phone}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;">Email<span style="color: red;"> *</span><br/>
                  <input type="text" id="email" name="email" value={{email}} style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;">Questions / Comments<br/>
                        <textarea id="comment" false name="comment"  style="max-width : 450px;" rows="10" class="form-control">{{comment}}</textarea>
                  </div>
              </div>
          </div>
          <div class='row'>
              <div style="padding-bottom: 18px;">
	              <input name="skip_Submit" value="Submit" type="submit"/>
	              <input type="button" value="Cancel" onclick="history.back()"/>
              </div>
          </div>
        </div>
    </div>
<!--
<div style="padding-bottom: 18px;font-size : 24px;">Guest edit</div>
<div style="display:none">
<input type="text" id="rowid" name="rowid" value={{rowid}} style="max-width : 450px;" class="form-control"/>
</div>
<div style=" margin-left: 0; margin-right: 1%; width: 49%;">Room number<span style="color:red;"> *</span><br/>
	<input type="text" id="room_no" name="room_no" value={{room_no}} style="max-width: 30%;" class="form-control"/>
</div>
<label for="status">Status</label>
<select id="status" name="status">
  <option value="Checked-in">Checked-in</option>
  <option value="Checked-out">Checked-out</option>
  <option value="Reservation">Reservation</option>
</select>
<div style="display: flex; padding-bottom: 18px;max-width : 450px;">
	<div style=" margin-left: 0; margin-right: 1%; width: 49%;">First name<span style="color: red;"> *</span><br/>
		<input type="text" id="first_name" name="first_name" value={{first_name}} style="max-width: 100%;" class="form-control"/>
	</div>
	<div style=" margin-left: 1%; margin-right: 0; width: 49%;">Last name<span style="color: red;"> *</span><br/>
		<input type="text" id="last_name" name="last_name" value={{last_name}} style="max-width: 100%;" class="form-control"/>
	</div>
</div>
<div style="padding-bottom: 18px;">Phone<span style="color: red;"> *</span><br/>
<input type="text" id="phone" name="phone" value={{phone}} style="max-width : 450px;" class="form-control"/>
</div>
<div style="padding-bottom: 18px;">Email<span style="color: red;"> *</span><br/>
<input type="text" id="email" name="email" value={{email}} style="max-width : 450px;" class="form-control"/>
</div>  
<div style="padding-bottom: 18px;">Arrival date<span style="color: red;"> *</span><br/>
<input type="text" id="arrival_date" name="arrival_date" value="{{arrival_date}}" style="max-width : 250px;" class="form-control"/>
</div>
<script type="text/javascript">new Pikaday({ field: document.getElementById('arrival_date')});</script>
<div style="padding-bottom: 18px;">Departure date<span style="color: red;"> *</span><br/>
<input type="text" id="departure_date" name="departure_date" value="{{departure_date}}" style="max-width : 250px;" class="form-control"/>
</div>
<script type="text/javascript">new Pikaday({ field: document.getElementById('departure_date') });</script>
<div style="padding-bottom: 18px;">Number of adults<span style="color: red;"> *</span><br/>
<input type="number" id="no_adults" name="no_adults" value={{no_adults}} style="max-width : 250px;" class="form-control"/>
</div>
<div style="padding-bottom: 18px;">Number of children<br/>
<input type="number" id="no_children" name="no_children" value={{no_children}} style="max-width : 250px;" class="form-control"/>
</div>
<div style="padding-bottom: 18px;">Questions / Comments<br/>
<textarea id="comment" name="comment" style="max-width : 450px;" rows="6" class="form-control">{{comment}}</textarea>
</div>

<div style="padding-bottom: 18px;">
	<input name="skip_Submit" value="Submit" type="submit"/>
	<input type="button" value="Cancel" onclick="history.back()"/>
</div>
-->
</form>
</div>
<script type="text/javascript">
      function validateForm() {
        if (isEmpty(document.getElementById('room_no').value.trim())) {
        alert('Room number is required!');
        return false;
        }
        if (isEmpty(document.getElementById('first_name').value.trim())) {
        alert('First name is required!');
        return false;
        }
        if (isEmpty(document.getElementById('last_name').value.trim())) {
        alert('Last name is required!');
        return false;
        }
        if (isEmpty(document.getElementById('phone').value.trim())) {
        alert('Phone is required!');
        return false;
        }
        if (isEmpty(document.getElementById('email').value.trim())) {
        alert('Email is required!');
        return false;
        }
        if (!validateEmail(document.getElementById('email').value.trim())) {
        alert('Email must be a valid email address!');
        return false;
        }
        if (isEmpty(document.getElementById('arrival_date').value.trim())) {
        alert('Arrival date is required!');
        return false;
        }
        if (isEmpty(document.getElementById('departure_date').value.trim())) {
        alert('Departure date is required!');
        return false;
        }
        if (isEmpty(document.getElementById('no_adults').value.trim())) {
        alert('Number of adults is required!');
        return false;
        }
        return true;
        }
      function isEmpty(str) { return (str.length === 0 || !str.trim()); }
      function validateEmail(email) {
        var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,15}(?:\.[a-z]{2})?)$/i;
        return isEmpty(email) || re.test(email);
      }
      function selectElement(id, valueToSelect) {    
          let element = document.getElementById(id);
          element.value = valueToSelect;
      }
      selectElement('status', '{{status}}');
</script>

