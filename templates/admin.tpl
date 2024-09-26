  % include('templates/header.tpl',page_title='')
  <div class="container"style="margin-top:20;" >
    <div class="row">
	    <h1><span data-i18n="welcome"></span> Hotel {{hotel_name}} - <span data-i18n="administration"</span></h1>
	  </div>
	  <div class="row">
	  	% include('templates/admin-navigation.tpl')
	  </div>
  	<div class="row">
    	<div class="column"
		    <p>This section of the application is restricted to hotel administrators only.</p> 
		    % include('templates/footer.tpl')
	    </div>
  	</div>
  </div>
  
