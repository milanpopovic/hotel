  <div class="container">
	  <div class="row">
	  	% include('templates/header.tpl',page_title='Boutique Hotel Management')
	  </div>
	  <div class="row">
	  	% include('templates/admin-navigation.tpl')
	  </div>
  	  <div class="row">
    	<div class="column"
		  <p>This part of application is accessible only by system administartors.</p> 
		  <p>Administartor may change user's data, room's data, set up hotel information and control IoT devices.</p>
		  % include('templates/footer.tpl')
		</div>
  	  </div>
  </div>
  
  
