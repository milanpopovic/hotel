% include('templates/header.tpl',page_title='')
<script src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/pikaday.min.js" type="text/javascript"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.4.0/css/pikaday.min.css" rel="stylesheet" type="text/css" />
<style>
@media print {
  .no-print {
    visibility: hidden;
  }
}
</style>
<div class="container" style="margin-top:20" >
    <div class="row">
        <div class="column">
			<h1><span style="font-size:50;color:#FFD700;vertical-align:top;font-weight: bold;" data-i18n="invoice"></span></h1>
		</div>
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
			<span data-i18n="invoice"></span>: {{rowid}}/2024<br/>
			<span data-i18n="issuedate"></span> : <span contenteditable>{{departure_date}}</span></p>
		</div>
	</div>
	<div class="row">
		<table>
		<tr border=0>
		<th><span data-i18n="arrivaldate"></span></th>
		<th><span data-i18n="departuredate"></span></th>
		<th><span data-i18n="numberofnights"></span></th>
		<th><span data-i18n="pricepernight"></span></th>
		<th style="text-align: right"><span data-i18n="total"></span> (<span data-i18n="currency"></span>)</th>
		</tr>
		<tr>
		<td>{{arrival_date}}</td>
		<td>{{departure_date}}</td>
		<td>{{days}}</td>
		<td>{{price}}</td>
		<td style="text-align: right">{{total}}</td>
		</tr>
		<tr>
		<td colspan=3></td>
		<td>Tax/VAT ({{hotel_vat}}%)</td>
		<td style="text-align: right">{{vat}}</td>
		</tr>
		<tr>
		<td colspan=3></td>
		<td><b><span data-i18n="total"></span></b> </td>
		<td style="text-align: right" ><b>{{total}}</b></td>
		</tr>
		</table>
	</div>
	<div class="row">
	    <div class="column">
			<h5><span data-i18n="thanks"></span></h5>
			<p contenteditable><span data-i18n="terms"></span>:</p>
		</div>
	</div>
	<button onclick="window.print()" class="no-print">Print</button>
	 <input type="button" value="Cancel" onclick="history.back()" class="no-print"/>
</div>
