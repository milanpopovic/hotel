 <!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic">

<!-- CSS Reset -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css">

<!-- Milligram CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css">

<!-- You should properly set the path from the main file. -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<script>
  function editGuest(row){
     location.href="/edit_guest/"+row.cells[0].textContent;
  }

  function Search(){
     text = document.getElementById("search-text").value;
     location.href = "/guest_search/"+encodeURIComponent(text)+"/{{title}}";
}

const selectAllCheckboxes = () => {
  const checkboxes = document.querySelectorAll('input[type=checkbox]');
  let checked = true;
  if (checkboxes[0].checked == false)  checked= false;
  checkboxes.forEach((cb) => { cb.checked = checked; });
}
</script>
   % visible = 'hidden' if title =='Reservation' else ''
   % hide = 'display:none;' if title != 'Reservation' else ''
   <div  class="container" style="margin-top:20;">
   <div><h3><a href="/"><i class="material-icons" style="font-size:36px; vertical-align: middle;">home</i></a>&nbsp;&nbsp;{{title}}</h3></div>
   <div><a href="/find_free_room" class="button button-outline" style="{{hide}}" >New Guest</a><a href="/booking_import" class="button button-outline" style="{{hide}}" >Booking import</a>
   <input type="text" placeholder="Search ..." id="search-text" name="search-text" style="max-width:600;" onchange="Search()" >
   </div>
  <table id="mytable">
   <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th><input type="checkbox" id="checkbox-0}"  onclick="selectAllCheckboxes()" /></th>
      <th>Room No.</th>
      <th>First name</th>
      <th>Last name</th>
      <th>Arrival date</th>
      <th>Departure date</th>
      <th style="display:none;">Email</th>
      <th>Comment</th>
    </tr>
   </thead>
   <tbody>
    % i = 0
    % for rowid,room_no, first_name,last_name,  phone, email,city,address,country, arrival_date, departure_date,no_adults, no_children,comment,status in guests:
    % i = i + 1
   <!--   <tr onclick="highlight(this);">-->
      <tr onclick="editGuest(this);">
      <td style="display:none;">{{rowid}}</td>
      <td><input type="checkbox" id="checkbox-{{i}}" onClick="event.stopPropagation();"/></td>
      <td>{{room_no}}</td>
      <td>{{first_name}}</td>
      <td>{{last_name}}</td>
      <td>{{arrival_date}}</td>
      <td>{{departure_date}}</td>
      <td style="display:none;" >{{email}}
      <td>{{comment}}</td>
      </tr>
    % end
  </tbody>
  </table>
  % include('templates/footer.tpl')
  </div>

<!-- the form -->
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
<style>
{box-sizing: border-box;}

/* the popup form - hidden by default */
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
    document.getElementById("to_guest").value = table_row.cells[7].textContent
    document.getElementById("id").value = table_row.cells[1].textContent
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
