<link rel="stylesheet" href="../static/css/milligram.min.css" />
<style>
.hidetext { -webkit-text-security: disc; /* Default */ }
</style>
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
    location.href="/edit_user/"+SelectedRow;
}

function SelectAction(dropdown)
{
    if(!SelectedRow){ 
        alert("Select a user");
        dropdown.selectedIndex = 0;
        return;
    }
    // Your code to make something happen.
    var option_value = dropdown.options[dropdown.selectedIndex].value;
    var option_text = dropdown.options[dropdown.selectedIndex].text;
    //alert('The option value is "' + option_value + '"\nand the text is "' + option_text + '"');
    switch(option_value){
      case 'edit': location.href="/edit_user/"+SelectedRow;break;
      case 'send-email': SendEmail(SelectedRow);break;
      case 'send-sms': SendSms(SelectedRow);break;
      case 'delete': location.href="/delete_user/"+SelectedRow;break;
      default: break;
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
  document.getElementById("to_user").value = table_row.cells[3].textContent
  document.getElementById("id").value = table_row.cells[0].textContent
  //let message = prompt("Please enter your message");
  //location.href='/send_email/user/'+id+'/' + encodeURIComponent(message);
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

function closeForm() {
  document.getElementById("myForm").style.display = "none";
}
</script>
<div class="container"style="margin-top:20">
<h3><a href="javascript:history.back()"><b> &#127968; </b></a> Users</h3>
<a class="button" href="/new_user"><span class="pln"> New</span></a> 
   <span class="pln"><a href="javascript:ToggleAction()">&#9881;</a> 
   <select id="action" onchange="SelectAction(this)" style="max-width : 150px;" >
    <option value="">Actions</option>
    <option value="edit">View/Edit</option>
    <option value="send-email">Send Email</option>
    <option value="send-sms">Send SMS</option>
    <option value="delete">Delete</option>
   </select>
   </span>
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Login</th>
      <th>Password</th>
      <th>Email</th>
      <th>Mobile</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,login,password,email,phone,status in users:
      <tr onclick="highlight(this);">
      <td style="display:none;">{{rowid}}</td>
      <td>{{login}}</td>
      <td class="hidetext">{{password}}</td>
      <td>{{email}}</td>
      <td>{{phone}}</td>
      <td>{{status}}</td>
      </tr>
    % end
  </tbody>
  </table>
% include('templates/footer.tpl')
</div>

<!-- The form -->
<div class="form-popup" id="myForm">
  <form action="/send_mail" method="POST" class="form-container">
    <label for="to"><b>To: </b></label><input type="text" placeholder="Enter Recipient" name="to" id="to_user">
    <label for="subject"><b>Subject</b></label>
    <input type="text" placeholder="Enter Subject" name="subject" required>
    <label for="psw"><b>Message</b></label>
    <textarea id="msg" name="msg"  style="max-width : 600px;height: auto; background: white;" rows="8" class="form-control"></textarea>
    <input type="text" name="who" style="display:none" value="user">
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
