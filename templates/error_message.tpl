<link rel="stylesheet" href="../static/css/milligram.min.css" />
<style>


/* The popup form - hidden by default */
.error-popup {
  display: none;
  position: fixed;
  top: 20;
  left:10%;
  bottom: 0;
  right: 15px;
  z-index: 9;
}
</style>

<div class="error-popup" id="error">
    <h2>Error</h2>
    <p id="message">{{message}}</p>
    <button type="button" onclick="closeError()">Close</button>
</div>
<script>
   
	function openError() {
	  document.getElementById("error").style.display = "block";
	}

	function closeError() {
	  history.back();
	  document.getElementById("error").style.display = "none";
	}
	openError();
</script>


