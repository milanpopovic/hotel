% include('templates/header.tpl',page_title='')
<script src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/pikaday.min.js" type="text/javascript"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/css/pikaday.min.css" rel="stylesheet" type="text/css" />
<div class="container" style="margin-top:20;">
<div class='row'>
    <div><h3><a href="/"><i class="material-icons" style="font-size:36px; vertical-align: middle;">home</i></a>&nbsp;&nbsp;<span data-i18n="edit">{{status}}</span> : {{first_name}} {{last_name}}</h3></div>
</div>
<style>
input, option, select{
  font-size:16px;
  color: gray;
}
</style>
<div class='row'>
    <div style="padding-bottom: 18px;">
        <button type="submit" form="guest_form" class="button button-outline"><span data-i18n="save"></span></button>
	      <!--<input name="Submit" value="Submit" type="submit" class="button button-outline"/>-->
	      <button onclick="location.href='/invoice/{{rowid}}'" class="button button-outline"><span data-i18n="invoice"></span></button>
	      <button onclick="SendEmail({{rowid}})" class="button button-outline"><span data-i18n="sendemail"></span></button>
	      <button onclick="SendSms({{rowid}})" class="button button-outline"><span data-i18n="sendsms"></span></button>
	      <button onclick="location.href='/delete_guest/{{rowid}}'" class="button button-outline"><span data-i18n="delete"></span></button>
    </div>
</div>

<div class="row">
        <form method="post" id="guest_form" action="/update_guest" onSubmit="return validateForm();">
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
                  <div style=" margin-left: 0; margin-right: 1%; width: 49%;"><span data-i18n="roomno"></span><span style="color:red;"> *</span><br/>
	                  <input type="text" id="room_no" name="room_no" value="{{room_no}}" style="max-width: 30%;" class="form-control"/>
                  </div>
                  </br>
                  <div style="display: flex; padding-bottom: 18px;max-width : 450px;">
	                  <div style=" margin-left: 0; margin-right: 1%; width: 49%;"><span data-i18n="firstname"></span><span style="color: red;"> *</span><br/>
		                  <input type="text" id="first_name" name="first_name" value="{{first_name}}" style="max-width: 100%;" class="form-control"/>
	                  </div>
	                  <div style=" margin-left: 1%; margin-right: 0; width: 49%;"><span data-i18n="lastname"></span><span style="color: red;"> *</span><br/>
		                  <input type="text" id="last_name" name="last_name" value="{{last_name}}" style="max-width: 100%;" class="form-control"/>
	                  </div>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="arrivaldate"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="arrival_date" name="arrival_date" value="{{arrival_date}}" style="max-width : 250px;" class="form-control"/>
                  </div>
                  <script type="text/javascript">new Pikaday({ field: document.getElementById('arrival_date') });</script>
                  <div style="padding-bottom: 18px;"><span data-i18n="departuredate"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="departure_date" name="departure_date" value="{{departure_date}}" style="max-width : 250px;" class="form-control"/>
                  </div>
                  <script type="text/javascript">new Pikaday({ field: document.getElementById('departure_date') });</script>
                  <div style="padding-bottom: 18px;"><span data-i18n="adultsno"></span><span style="color: red;"> *</span><br/>
                  <input type="number" id="no_adults" name="no_adults" value="{{no_adults}}" style="max-width : 250px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="childrenno"></span><br/>
                  <input type="number" id="no_children" name="no_children" value="{{no_children}}" style="max-width : 250px;" class="form-control"/>
                  </div>
              </div>
              <div class='column'column-50" >
                  <div style="padding-bottom: 18px;"><span data-i18n="city"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="city" name="city" value="{{city}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="address"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="address" name="address" value="{{address}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="country"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="country" name="country" value="{{country}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="mobile"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="phone" name="phone" value="{{phone}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="email"></span><span style="color: red;"> *</span><br/>
                  <input type="text" id="email" name="email" value="{{email}}" style="max-width : 450px;" class="form-control"/>
                  </div>
                  <div style="padding-bottom: 18px;"><span data-i18n="comment"></span><br/>
                        <textarea id="comment" false name="comment"  style="max-width : 450px;height: auto;" rows="8" class="form-control">{{comment}}</textarea>
                  </div>
              </div>
          </div>
        </div>
    </div>
</form>
</div>

<!-- The form -->
<div class="form-popup" id="myForm">
  <form action="/send_mail" method="POST" class="form-container">
    <label for="to"><b>To: </b></label><input type="text" placeholder="Enter Recipient" name="to" id="to_guest">
    <label for="subject"><b>Subject</b></label>
    <input type="text" placeholder="Enter Subject" name="subject" required>
    <label for="psw"><b>Message</b></label>
    <textarea id="msg" name="msg"  style="max-width : 600px;height: auto; background: white;" rows="8" class="form-control"></textarea>
    <input type="text" name="who" style="display:none" value="guest">
    <input type="text" name="id" id="id" style="display:none">
    <button type="submit" >Send</button>
    <button type="button" onclick="closeForm()">Cancel</button>
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


<style>
{box-sizing: border-box;}

/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  top: 20;
  left:35%;
  bottom: 0;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 500px;
  padding: 10px;
  background-color: #f1f1f1; /*white;*/
}

/* Full-width input fields */
.form-container input[type=text] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: white; /*#f1f1f1;*/
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus {
  background-color: #ddd;
  outline: none;
}
</style>
<script>
  function SendEmail(id){
    openForm();
    document.getElementById("to_guest").value = "{{email}}"
    document.getElementById("id").value = {{rowid}}
  }

  function SendSms(id){
    let message = prompt("Please enter your message");
    if (message)alert("Send SMS message: "+message+" to userid:"+id+" not implemented");
  }

  function openForm() {
    document.getElementById("myForm").style.display = "block";
  }

  function closeForm() {
    document.getElementById("myForm").style.display = "none";
  }
</script>

