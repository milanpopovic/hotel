  % include('templates/header.tpl',page_title='Guest Management')
  % include('templates/navigation.tpl')
 
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
      location.href="/edit_guest/"+SelectedRow;
  }
  
  function SelectAction(dropdown)
{
    console.log(dropdown);
    if(!SelectedRow){ 
        alert("Select a guest");
        dropdown.selectedIndex = 0;
        return;
    }
    // Your code to make something happen.
    var option_value = dropdown.options[dropdown.selectedIndex].value;
    var option_text = dropdown.options[dropdown.selectedIndex].text;
    //alert('The option value is "' + option_value + '"\nand the text is "' + option_text + '"');
   
    switch(option_value){
      case 'edit': location.href="/edit_guest/"+SelectedRow;break;
      case 'delete': location.href="/delete_guest/"+SelectedRow;break;
      case 'checkin': location.href="/checkin/"+SelectedRow;break;
      case 'checkout': location.href="/checkout/"+SelectedRow;break;
      case 'reservation': location.href="/reservation/"+SelectedRow;break;
      case 'invoice': location.href="/invoice/"+SelectedRow;break;
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
   <h2>{{title}}</h2>
   <a class="button" href="/new_guest"><span class="pln">New</span></a> 
   <span class="pln"><a href="javascript:ToggleAction()">&#9881;</a> 
   <select id="action" onchange="SelectAction(this)" style="max-width : 150px;" >
    <option value="">Actions</option>
    <option value="edit">View/Edit</option>
    <option value="delete">Delete</option>
    <option value="invoice">Invoice</option>
    <!--
    <option value="checkin">Check-in</option>
    <option value="checkout">Check-out</option>
    <option value="reservation">Reservation</option>
    -->
   </select>
   </span>

  <!--<button onclick="getSelectedRow()">Edit selected</button>-->
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Room No.</th>
      <th>First name</th>
      <th>Last name</th>
      <th>Phone</th>
      <th>Email</th>
      <th>Arrival date</th>
      <th>Departure date</th>
      <th>No. of adults</th>
      <th>No. of children</th>
      <th>Comment</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,room_no, first_name,last_name,  phone, email,city,address,country, arrival_date, departure_date,no_adults, no_children,comment,status in guests:
      <tr onclick="highlight(this);">
      <td style="display:none;">{{rowid}}</td>
      <td>{{room_no}}</td>
      <td>{{first_name}}</td>
      <td>{{last_name}}</td>
      <td>{{phone}}</td>
      <td>{{email}}</td>
      <td>{{arrival_date}}</td>
      <td>{{departure_date}}</td>
      <td>{{no_adults}}</td>
      <td>{{no_children}}</td>
      <td>{{comment}}</td>
      <td>{{status}}</td>
      </tr>
    % end
  </tbody>
  </table>
  % include('templates/footer.tpl')
