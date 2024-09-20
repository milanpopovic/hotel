<link rel="stylesheet" href="../static/css/milligram.min.css" />
<div class="container">
<form method="post" action="/update_device" onSubmit="return validateForm();">
  <div style="padding-bottom: 18px;font-size : 24px;">View/Edit User</div>
  <fieldset>
    <div style="display:none">
    <input type="text" id="rowid" name="rowid" value={{rowid}} style="max-width : 450px;" class="form-control"/>
    </div>
    <label for="name">Name</label>
    <input type="text" placeholder="name" id="name" name="name" value="{{name}}">
    <label for="ip">ip</label>
    <input type="ip" placeholder="ip" id="ip" name="ip" value={{ip}}>
    <label for="status">Status</label>
    <select id="status" name="status">
      <option value="ON">ON</option>
      <option value="OFF">OFF</option>
    </select>
     <div style="padding-bottom: 18px;">Comment<br/>
        <textarea id="comment" false name="comment"  style="max-width : 450px;height: auto;" rows="8" class="form-control">{{comment}}</textarea>
    </div>
    <input class="button-primary" type="submit" value="Save">
    <input type="button" value="Cancel" onclick="history.back()"/> 
  </fieldset>
</form>
</div>
<script>
function validateForm(){
    return true;
}

function selectElement(id, valueToSelect) {    
    let element = document.getElementById(id);
    element.value = valueToSelect;
}
selectElement('status', '{{status}}');
</script>

