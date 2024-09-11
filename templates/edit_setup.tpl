<link rel="stylesheet" href="../static/css/milligram.min.css" />

<form method="post" action="/save_setup" onSubmit="return validateForm();">
<div class="container">
  <div class="row">
  <div style="padding-bottom: 18px;font-size : 24px;margin-top:30"">Hotel setup</div>
  </div>
  <div class="row">
  <div class="column">
  <fieldset>
    <label for="name">Hotel name</label>
    <input type="text" placeholder="Name" id="name" name="name" value="{{name}}">
    <label for='logo'>Logo file</label>
    <input ype="text" placeholder="logo file" id="logo" name="logo" value={{logo}}>
    <label for="address">Address(street,city)</label>
    <input type="text" placeholder="Address" id="address" name="address" value="{{address}}">
    <label for="address">Country</label>
    <input type="text" placeholder="Country" id="country" name="country" value="{{country}}">
    <label for="phone">Phone</label>
    <input type="text" placeholder="Phone" id="phone" name="phone" value={{phone}}>
    <label for="email">Email</label>
    <input type="text" placeholder="Email" id="email" name="email" value={{email}}>
  </fieldset>
  </div>
  <div class="column">
  <fieldset>
    <label for="email">VAT(%)</label>
    <input type="text" placeholder="VAT(%)" id="vat" name="vat" value={{vat}}>
    <label for="smtp_server">SMTP server</label>
    <input type="text" placeholder="smtp server" id="smtp_server" name="smtp_server" value={{smtp_server}}>
    <label for="port">Port</label>
    <input type="text" placeholder="port" id="port" name="port" value={{port}}>
    <label for="password">Password</label>
    <input type="password" placeholder="password" id="password" name="password" value="{{password}}">
  </fieldset>
  </div>
  </div>
  <div class="row">
    <fieldset>
	   <input class="button-primary" type="submit" value="Send">
	   <input type="button" value="Cancel" onclick="history.back()"/>
	</fieldset>
  </div>
 </div>
</form>

<script>
function validateForm(){
    return true;
}
