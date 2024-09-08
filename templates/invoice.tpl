<link rel="stylesheet" href="../static/css/milligram.min.css" />
<style>
@media print {
  .no-print {
    visibility: hidden;
  }
}
</style>
<!--
<div class="container">
<div><img src="../static/img/boutique.png" width="100" height="100"/><span style="font-size:50;color:#FFD700;vertical-align:top;font-weight: bold;">Royal Palace</span></div>
<hr/>
-->
<div class="container">
    <div class="row">
			<span style="font-size:50;color:#FFD700;vertical-align:top;font-weight: bold;">INVOICE</span>
	</div>
	<div class="row">
	    <div class="column">
	       <h3>Hotel {{hotel_name}}</h3>
	       <p>{{hotel_address}},{{hotel_country}}<br>
	       Phone {{hotel_phone}} Email: {{hotel_email}}</p>
	    </div>
		<div class="column">
			<h3>{{first_name}} {{last_name}}</h3>
			<p>{{city}}, {{address}}, {{country}}<br/>
			Phone: {{phone}}, Email: {{email}}<br/><br/>
			Invoice No: {{rowid}}/2024<br/>
			<span contenteditable>Issue Date: {{departure_date}}</span></p>
		</div>
	</div>
	<div class="row">
		<table>
		<tr border=0>
		<th>Arrival date</th>
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
		<td>Tax/VAT ({{hotel_vat}}%)</td>
		<td>{{vat}}</td>
		</tr>
		<tr>
		<td colspan=3></td>
		<td>TOTAL</td>
		<td>{{total}}</td>
		</tr>
		</table>
	</div>
	<div class="row">
	    <div class="column">
		<h5>THANK YOU FOR USING OUR SERVICES</h5>
		<p contenteditable>Invoice Terms:</p>
		</div>
	</div>
	<a href="javascript:history.back()" class="no-print">Go back</a>
</div>



