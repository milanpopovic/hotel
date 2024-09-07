<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/save_setup" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">View/Edit setup</div>
  <fieldset>
    <label for="name">Hotel name</label>
    <input type="text" placeholder="Name" id="name" name="name" value="{{name}}">
    <label for='logo'>Hotel logo file</label>
    <input ype="text" placeholder="logo file" id="logo" name="logo" value={{logo}}>
    <label for="address">address</label>
    <input type="text" placeholder="Address" id="address" name="address" value="{{address}}">
    <label for="address">country</label>
    <input type="text" placeholder="Country" id="country" name="country" value="{{country}}">
    <label for="phone">Hotel phone</label>
    <input type="text" placeholder="Phone" id="phone" name="phone" value={{phone}}>
    <label for="email">Hotel email</label>
    <input type="text" placeholder="Email" id="email" name="email" value={{email}}>
    <input class="button-primary" type="submit" value="Send">
    <input type="button" value="Cancel" onclick="history.back()"/>
  </fieldset>
</form>
</div>
<script>
function validateForm(){
    return true;
}
