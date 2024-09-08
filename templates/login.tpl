<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<h3>Hotel {{hotel}}</h3>
<form method="post" action="/login_check" onSubmit="return validateForm();">
  <!--<div style="padding-bottom: 18px;font-size : 24px;">Login</div>-->
  <fieldset>
    <label for="login">Login</label>
    <input type="text" placeholder="login" id="login" name="login" >
    <label for="password">Password</label>
    <input type="password" placeholder="password" id="password" name="password">
    <input class="button-primary" type="submit" value="Send">
    <input type="button" value="Cancel" onclick="history.back()"/>
  </fieldset>
</form>
</div>

