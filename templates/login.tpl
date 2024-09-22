<link rel="stylesheet" href="/static/css/milligram.min.css" />
<div class="container" style="margin-top:100;">
	<h3>Hotel {{hotel}}</h3>
	<form method="post" action="/login_check" onSubmit="return validateForm();">
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
<script>
function validateForm(){
   return true;
}

