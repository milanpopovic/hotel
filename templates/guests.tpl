 <link rel="stylesheet" href="../static/css/milligram.min.css" />
  <script>
  var SelectedRow = "";
  var fontColor = "";
  var table_row = "";
  
  function highlight(row) {
      if (SelectedRow!="" && SelectedRow == row.cells[0].textContent){
        deHighlight();
        SelectedRow="";
        return
      }
      SelectedRow=row.cells[0].textContent;
      table_row = row;
      deHighlight();
      fontColor =  row.style.color;
      row.style.backgroundColor = '#003F87';
      row.style.color = '#ffffff';
      row.classList.toggle("selectedRow");
  }

  function deHighlight() { 
      let table = document.getElementById("mytable");
      let rows = table.rows;
      for (let i = 0; i < rows.length; i++) {
          rows[i].style.backgroundColor = "transparent";
          rows[i].style.color = fontColor;
      }
  }

  function getSelectedRow() {
      location.href="/edit_guest/"+SelectedRow;
  }
  
  function SelectAction(dropdown)
  {
    // Your code to make something happen.
    var option_value = dropdown.options[dropdown.selectedIndex].value;
    var option_text = dropdown.options[dropdown.selectedIndex].text;

    if(!SelectedRow && option_value !== "import"){ 
        dropdown.selectedIndex = 0;
        return;
    }
    //alert('The option value is "' + option_value + '"\nand the text is "' + option_text + '"')
    switch(option_value){
      case 'edit': location.href="/edit_guest/"+SelectedRow;break;
      case 'delete': location.href="/delete_guest/"+SelectedRow;break;
      case 'send-email': SendEmail(SelectedRow);break;
      case 'send-sms': SendSms(SelectedRow);break;
      case 'invoice': location.href="/invoice/"+SelectedRow;break;
      case 'import': location.href="/booking_import";break;
      default: break;//alert("Booking.com API not installed");break;
    }
    dropdown.selectedIndex = 0;
}

function ToggleAction() {
  var x = document.getElementById("action");
  if (x.style.display === "none") {
    x.style.display = "inline";
  } else {
    x.style.display = "none";
    x.selectedIndex = 0;
  }
}

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

function Search(){
   text = document.getElementById("search-text").value;
   location.href = "/guest_search/"+encodeURIComponent(text);
}
</script>
   <div class="container" style="margin-top:20">
   <h3><a href="/"><b> &#127968; </b></a>{{title}}&nbsp;&nbsp;</h3>
   <a class="button" href="/new_guest"><span class="pln">New</span></a> 
   <span class="pln"><a href="javascript:ToggleAction()">&#9881;</a></span> 
   <select id="action" onchange="SelectAction(this)" style="max-width : 150px;" >
    <option value="" selected>Action</option>
    <optgroup label="Check out">
      <option value="invoice">Invoice</option>
    </optgroup>
    <optgroup label="Change data">
      <option value="edit">View/Edit</option>
      <option value="delete">Delete</option>
    </optgroup>
    <optgroup label="Send message">
      <option value="send-email">Email</option>
      <option value="send-sms">SMS</option>
    </optgroup>
    <optgroup label="Booking.com" id="booking">
      <option value="import">Import</option>
    </optgroup>
   </select>
   </span>
   Search: <input type="text" placeholder="Enter search text and press Enter" id="search-text" name="search-text" style="max-width:600" onchange="Search()" >
  
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
      <tr onclick="highlight(this);">
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
title="{{title}}"
if(title !=="Reservation") {
  document.getElementById("booking").style="display:none";
}
</script>
