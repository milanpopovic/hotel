<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
    location.href="/edit_device/"+SelectedRow;
}

function SelectAction(dropdown)
{
    if(!SelectedRow){ 
        alert("Select a device");
        dropdown.selectedIndex = 0;
        return;
    }
    // Your code to make something happen.
    var option_value = dropdown.options[dropdown.selectedIndex].value;
    var option_text = dropdown.options[dropdown.selectedIndex].text;
    //alert('The option value is "' + option_value + '"\nand the text is "' + option_text + '"');
    switch(option_value){
      case 'edit': location.href="/edit_device/"+SelectedRow;break;
      case 'delete': location.href="/delete_device/"+SelectedRow;break;
      case 'toggle-status':location.href="/toggle_status/"+SelectedRow;break;
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

</script>
<!--<div style="margin-left:10px;margin-top:10px">-->
<div class="container"style="margin-top:20" >
<h3><a href="/admin"><i class="material-icons" style="font-size:36px; vertical-align: middle;">home</i></a>&nbsp;&nbsp; IoT Devices</h3>
<a class="button" href="/new_device"><span class="pln"> New</span></a> 
   <span class="pln"><a href="/">&#9881;</a> 
   <select id="action" onchange="SelectAction(this)" style="max-width : 150px;" >
    <option value="">Actions</option>
    <option value="edit">View/Edit</option>
    <option value="delete">Delete</option>
    <option value="toggle-status">Toggle status</option>
   </select>
   </span>
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Name</th>
      <th>IP sddress</th>
      <th>Status</th>
      <th>Comment</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,name,ip,status,comment in devices:
    %  bgcolor = "red" if status == "ON" else "transparent"
    %  style="color: white" if status == "ON" else ""
      <tr onclick="highlight(this);">
      <td style="display:none;">{{rowid}}</td>
      <td bgcolor="{{bgcolor}}" style="{{style}}">{{name}}</td>
      <td>{{ip}}</td>
      <td>{{status}}</td>
      <td>{{comment}}</td>
      </tr>
    % end
  </tbody>
  </table>
% include('templates/footer.tpl')
</div>
