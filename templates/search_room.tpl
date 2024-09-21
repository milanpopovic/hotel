<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.min.css" integrity="sha512-xiunq9hpKsIcz42zt0o2vCo34xV0j6Ny8hgEylN3XBglZDtTZ2nwnqF/Z/TTCc18sGdvCjbFInNd++6q3J0N6g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/pikaday.min.js" type="text/javascript"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/css/pikaday.min.css" rel="stylesheet" type="text/css" />
 <div class="container" style="margin-top:20;">
        <div><h3><a href="/guests/Reservation"><i class="material-icons" style="font-size:36px; vertical-align: middle;">home</i></a>Find room&nbsp;&nbsp;</h3></div>
        <div class='row'>
                 <!-- <div style="padding-bottom: 18px;">Search<span style="color: red;"> *</span><br/>-->
                  <div></br>
                  <input name="Search" value="Search" type="submit" class="button button-outline form-conytrol"/>
                  </div>
                  <div style="padding-bottom: 18px;">Arrival date<span style="color: red;"> *</span><br/>
                  <input type="text" id="arrival_date" name="arrival_date" style="max-width : 250px;" class="form-control" value="{{arrival_date}}"/>
                  </div>
                  <script type="text/javascript">new Pikaday({ field: document.getElementById('arrival_date') });</script>
                  <div style="padding-bottom: 18px;">Departure date<span style="color: red;"> *</span><br/>
                  <input type="text" id="departure_date" name="departure_date" style="max-width : 250px;" class="form-control" value="{{departure_date}}"/>
                  </div>
                  <script type="text/javascript">new Pikaday({ field: document.getElementById('departure_date') });</script>
                  <div style="padding-bottom: 18px;">Number of beds<span style="color: red;"> *</span><br/>
                  <input type="number" id="beds" name="beds" style="max-width : 250px;" class="form-control" value="{{beds}}"/>
                  </div>
        </div>
</div>

<div class="container"style="margin-top:20" >
  <table id="mytable">
  <thead>
    <tr>
      <th style="display:none;">ID</th>
      <th>Room No.</th>
      <th>Floor</th>
      <th>Category</th>
      <th>Beds</th>
      <th>Price</th>
    </tr>
  </thead>
  <tbody>
    % for rowid,room_no,floor,category,beds,price in rooms:
      <tr onclick="highlight(this);">
      <td style="display:none;">{{rowid}}</td>
      <td>{{room_no}}</td>
      <td>{{floor}}</td>
      <td>{{category}}</td>
      <td>{{beds}}</td>
      <td>{{price}}</td>
      </tr>
    % end
  </tbody>
  </table>
  <a class="button" href="javascript:MakeReservation()"><span class="pln">Make reservation</span></a> 
  % include('templates/footer.tpl')

<script>
function validateData() {
  const today = new Date();
  const from_date = new Date(document.getElementById("arrival_date").value);
  const to_date = new Date(document.getElementById("departure_date").value);
  if (from_date < today) {
     alert('Arrival date must be greater than today!');
     return false;
  }
  if (from_date > to_date) {
     alert('Departure date must be greater or equal to arrival!');
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
  if (isEmpty(document.getElementById('beds').value.trim())) {
    alert('Number ob beds is required!');
    return false;
  }
  return true;
}
function isEmpty(str) { return (str.length === 0 || !str.trim()); }
var submit = document.getElementsByName('Search')[0];
submit.onclick = function() {
    if (!validateData()) return;
    from_date = document.getElementById("arrival_date").value;
    to_date = document.getElementById("departure_date").value;
    beds = document.getElementById("beds").value;
    location.href='/free_rooms/'+from_date+'/'+to_date+'/'+beds;
}
var SelectedRow = "";
var fontColor = "";
function highlight(row) {
    if (SelectedRow!="" && SelectedRow == row.cells[0].textContent){
      deHighlight();
      SelectedRow="";
      return
    }
    SelectedRow=row.cells[1].textContent;
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

function MakeReservation(){
   if(!SelectedRow){ 
        alert("Select a room");
        dropdown.selectedIndex = 0;
        return;
    }
   let arrival_date = document.getElementById("arrival_date").value;
   let departure_date = document.getElementById("departure_date").value;
   location.href="/room_reservation/"+SelectedRow+'/'+arrival_date+'/'+departure_date;
}
</script>




