<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.min.css" integrity="sha512-xiunq9hpKsIcz42zt0o2vCo34xV0j6Ny8hgEylN3XBglZDtTZ2nwnqF/Z/TTCc18sGdvCjbFInNd++6q3J0N6g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
    //alert(SelectedRow);
    location.href="/edit_room/"+SelectedRow;
}

function SelectAction(dropdown)
{
    // Your code to make something happen.
    var option_value = dropdown.options[dropdown.selectedIndex].value;
    var option_text = dropdown.options[dropdown.selectedIndex].text;
    //alert('The option value is "' + option_value + '"\nand the text is "' + option_text + '"');
    
    
    if(!SelectedRow  && option_value != 'find'){ 
        alert("Select a room");
        dropdown.selectedIndex = 0;
        return;
    }
    
    switch(option_value){
      case 'edit': location.href="/edit_room/"+SelectedRow;break;
      case 'copy': location.href="/copy_room/"+SelectedRow;break;
      case 'delete': location.href="/delete_room/"+SelectedRow;break;
      case 'find': location.href="/find_free_room";break;
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
<div class="container"style="margin-top:20" >
<h3><a href="/admin"><b> &#127968; </b></a>Rooms</h3>
<a class="button" href="/new_room"><span class="pln">New</span></a> 
   <span class="pln"><a href="javascript:ToggleAction()">&#9881;</a> 
   <select id="action" onchange="SelectAction(this)" style="max-width : 150px;" >
    <option value="">Actions</option>
    <option value="edit">View/Edit</option>
    <option value="copy">Copy</option>
    <option value="delete">Delete</option>
    <option value="find">Find free</option>
   </select>
   </span>
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Room No.</th>
      <th>Floor</th>
      <th>Category</th>
      <th>Beds</th>
      <th>Price</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,room_no,floor,category,beds,price,status in rooms:
      <tr onclick="highlight(this);">
      <td style="display:none;">{{rowid}}</td>
      <td>{{room_no}}</td>
      <td>{{floor}}</td>
      <td>{{category}}</td>
      <td>{{beds}}</td>
      <td>{{price}}</td>
      <td>{{status}}</td>
      </tr>
    % end
  </tbody>
  </table>
% include('templates/footer.tpl')
<div style="margin-left:10px;margin-top:10px">
