<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="../static/css/milligram.min.css" />
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
    location.href="/edit_asset/"+SelectedRow;
}

function SelectAction(dropdown)
{
    if(!SelectedRow){ 
        alert("Select an asset");
        dropdown.selectedIndex = 0;
        return;
    }
    // Your code to make something happen.
    var option_value = dropdown.options[dropdown.selectedIndex].value;
    var option_text = dropdown.options[dropdown.selectedIndex].text;
    //alert('The option value is "' + option_value + '"\nand the text is "' + option_text + '"');
    switch(option_value){
      case 'edit': location.href="/edit_asset/"+SelectedRow;break;
      case 'delete': location.href="/delete_asset/"+SelectedRow;break;
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
<div class="container" style="margin-top:20">
<h3><a href="/admin"><i class="material-icons" style="font-size:36px; vertical-align: middle;">home</i></a>&nbsp;&nbsp;Inventory</h3>
<a class="button" href="/new_asset"><span class="pln">New</span></a> 
   <span class="pln"><a href="javascript:ToggleAction()">&#9881;</a> 
   <select id="action" onchange="SelectAction(this)" style="max-width : 150px;" >
    <option value="">Actions</option>
    <option value="edit">View/Edit</option>
    <option value="delete">Delete</option>
   </select>
   </span>
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Name</th>
      <th>Location</th>
      <th>Category</th>
      <th>Year</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,name,location,category,year,status in assets:
      <tr onclick="highlight(this);">
      <td style="display:none;">{{rowid}}</td>
      <td>{{name}}</td>
      <td>{{location}}</td>
      <td>{{category}}</td>
      <td>{{year}}</td>
      <td>{{status}}</td>
      </tr>
    % end
  </tbody>
  </table>
% include('templates/footer.tpl')
<div style="margin-left:10px;margin-top:10px">
