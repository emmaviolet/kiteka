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

  $(function() {
  $('.directUpload').find("input:file").each(function(i, elem) {
    var fileInput    = $(elem);
    var form         = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);
    fileInput.fileupload({
      fileInput:       fileInput,
      url:             form.data('url'),
      type:            'POST',
      autoUpload:       true,
      formData:         form.data('form-data'),
      paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
      replaceFileInput: false,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
      },
      start: function (e) {
        submitButton.prop('disabled', true);

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.text("Uploading done");

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '//' + form.data('host') + '/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);

        progressBar.
          css("background", "red").
          text("Failed");
      }
    });
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