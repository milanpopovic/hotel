 <link rel="stylesheet" href="../static/css/milligram.min.css" />
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script>
/*
  var SelectedRow = "";
  var fontColor = "";
  var table_row = "";
*/
  function editGuest(row){
     location.href="/edit_guest/"+row.cells[0].textContent;
  }

function Search(){
   text = document.getElementById("search-text").value;
   location.href = "/guest_search/"+encodeURIComponent(text);
}
</script>
   % visible = 'hidden' if title =='Reservation' else ''
   % hide = 'display:none;' if title != 'Reservation' else ''
   <div class="container" style="margin-top:20;">
   <div><h3><a href="/"><i class="material-icons" style="font-size:36px; vertical-align: middle;">home</i></a>&nbsp;&nbsp;{{title}}</h3></div>
   <div><a href="/find_free_room" class="button button-outline" style="{{hide}}" >New Guest</a>
   <input type="text" placeholder="Search ..." id="search-text" name="search-text" style="max-width:800;" onchange="Search()" >
   </div>
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Room No.</th>
      <th>First name</th>
      <th>Last name</th>
      <th>Arrival date</th>
      <th>Departure date</th>
      <th>Email</th>
      <th>Comment</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,room_no, first_name,last_name,  phone, email,city,address,country, arrival_date, departure_date,no_adults, no_children,comment,status in guests:
   <!--   <tr onclick="highlight(this);">-->
      <tr onclick="editGuest(this);">
      <td style="display:none;">{{rowid}}</td>
      <td>{{room_no}}</td>
      <td>{{first_name}}</td>
      <td>{{last_name}}</td>
      <td>{{arrival_date}}</td>
      <td>{{departure_date}}</td>
      <td>{{email}}
      <td>{{comment}}</td>
      </tr>
    % end
  </tbody>
  </table>
  % include('templates/footer.tpl')
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
    document.getElementById("to_guest").value = table_row.cells[6].textContent
    document.getElementById("id").value = table_row.cells[0].textContent
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
