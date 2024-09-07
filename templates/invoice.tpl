<link rel="stylesheet" href="../static/css/milligram.min.css" />

<div class="container">
<div><img src="../static/img/boutique.png" width="100" height="100"/><span style="font-size:50;color:#FFD700;vertical-align:top">Royal Palace</span></div>
<hr/>
<b>{{first_name}} {{last_name}}</b>
<!--<p>Phone: {{phone}}, Email: {{email}}</p>-->
<p>{{city}}, {{address}}, {{country}}</p>
<b><hr></b>
<h2>Invoice {{rowid}}/2024</h2>
<!--<h2>Room {{room_no}}</h2>-->
<table>
<tr border=0>
<th>Arrival day</th>
<th>Departure date</th>
<th>Number of days</th>
<th>Price per day</th>
<th>Total ($)</th>
</tr>
<tr>
<td>{{arrival_date}}</td>
<td>{{departure_date}}</td>
<td>{{days}}</td>
<td>{{price}}</td>
<td>{{total}}</td>
</tr>
<tr>
<td colspan=3></td>
<td>VAT (20%)</td>
<td>{{vat}}</td>
</tr>
<tr>
<td colspan=3></td>
<td>TOTAL</td>
<td>{{total}}</td>
</tr>
</table>
<div>

