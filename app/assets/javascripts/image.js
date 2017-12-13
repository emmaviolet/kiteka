$(document).ready(function(){
  $( ".btn-primary" ).click(function() {
  	var elementId = this.id;
  	var idNumber = elementId.split('_')[1];
  	var nextIdNumber;

  	var response = elementId.split('_')[2];
  	if (response == 'back') {
  		nextIdNumber = parseInt(idNumber) - 1;
  	} 
  	else {
  		nextIdNumber = parseInt(idNumber) + 1;
  	}

  	var elementIdToShow = '#question_' + nextIdNumber.toString();
  	$('.question_div').not(elementIdToShow).hide();
  	$(elementIdToShow).show();

  	var buttonGroups = $(".input-btn-primary:visible").each(function(index) {
    	var formActions = $( this )[0].form['action'].split('&');
    	console.log($( this )[0].form['action']);
    	
    	var now = new Date();
		var isoString = now.toISOString();

    	formActions[3] = "start_time=" + isoString;
    	var newForm = formActions.join('&');
    	$( this )[0].form['action'] = newForm;

    	console.log($( this )[0].form['action']);
  	});
  });

  $(window).keydown(function(e) {
	  switch (e.keyCode) {
	    case 37: 
	    	var visibleDivId = $( ".question_div:visible" ).attr('id');
	    	$('#' + visibleDivId + '_no').trigger('click');
	    	break;
	    case 38:
	    	var visibleDivId = $( ".question_div:visible" ).attr('id');
	    	$('#' + visibleDivId + '_back').trigger('click');
	    	break;
	    case 39:
	    	var visibleDivId = $( ".question_div:visible" ).attr('id');
	    	$('#' + visibleDivId + '_yes').trigger('click');
	    	break;
	    case 40: 
	    	var visibleDivId = $( ".question_div:visible" ).attr('id');
	    	$('#' + visibleDivId + '_uncertain').trigger('click');
	    	break;
	    default:
	    	break;
	  }
	});
});