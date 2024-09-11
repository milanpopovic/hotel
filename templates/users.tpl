<link rel="stylesheet" href="../static/css/milligram.min.css" />
<style>
.hidetext { -webkit-text-security: disc; /* Default */ }
</style>
<script>
var SelectedRow = "";
var fontColor = "";

function highlight(row) {
    if (SelectedRow!="" && SelectedRow == row.cells[0].textContent){
      deHighlight();
      SelectedRow="";
      return
    }
    SelectedRow=row.cells[0].textContent;
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
  let message = prompt("Please enter your message");
  location.href='/send_email/user/'+id+'/' + encodeURIComponent(message);
}
function SendSms(id){
  let message = prompt("Please enter your message");
  if (message)alert("Send SMS message: "+message+" to userid:"+id+" not implemented");
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
