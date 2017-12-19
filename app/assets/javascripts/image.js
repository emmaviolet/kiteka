
$(document).ready(function(){
    // Note that this is directly linking to the question
  // as the only place you can swipe to answer.
  // I'd quite like to make this a pop-up box with slightly larger buttons
  // that auto hides if you double tap (so people can look at the images more)
  
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
      
      var now = new Date();
    var isoString = now.toISOString();

      formActions[3] = "start_time=" + isoString;
      var newForm = formActions.join('&');
      $( this )[0].form['action'] = newForm;
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

  function goLeft(){
    var visibleDivId = $( ".question_div:visible" ).attr('id');
      $('#' + visibleDivId + '_no').trigger('click');
  }
  
  function goRight(){
    var visibleDivId = $( ".question_div:visible" ).attr('id');
      $('#' + visibleDivId + '_yes').trigger('click');
  }
  
  function goUp(){
    var visibleDivId = $( ".question_div:visible" ).attr('id');
      $('#' + visibleDivId + '_back').trigger('click');
  }
  
  function goDown(){
    var visibleDivId = $( ".question_div:visible" ).attr('id');
      $('#' + visibleDivId + '_uncertain').trigger('click');
  }

  $(window).keydown(function(e) {
    switch (e.keyCode) {
      case 37: 
        goLeft();
        break;
      case 38:
        goUp();
        break;
      case 39:
        goRight();
        break;
      case 40: 
        goDown();
        break;
      default:
        break;
    }
  });
  
  

  
  var triggerElementID = "question"; // this variable is used to identity the triggering element
  var fingerCount = 0;
  var startX = 0;
  var startY = 0;
  var curX = 0;
  var curY = 0;
  var deltaX = 0;
  var deltaY = 0;
  var horzDiff = 0;
  var vertDiff = 0;
  var minLength = 72; // the shortest distance the user may swipe
  var swipeLength = 0;
  var swipeAngle = null;
  var swipeDirection = null;


  var touchCancel = function() {
    // reset the variables back to default values
    fingerCount = 0;
    startX = 0;
    startY = 0;
    curX = 0;
    curY = 0;
    deltaX = 0;
    deltaY = 0;
    horzDiff = 0;
    vertDiff = 0;
    swipeLength = 0;
    swipeAngle = null;
    swipeDirection = null;
    // triggerElementID = null; // only needs uncommenting if binding to multiple objects - don't.
  }

  function calculateAngle() {
    var X = startX-curX;
    var Y = curY-startY;
    var Z = Math.round(Math.sqrt(Math.pow(X,2)+Math.pow(Y,2))); //the distance - rounded - in pixels
    var r = Math.atan2(Y,X); //angle in radians (Cartesian system)
    swipeAngle = Math.round(r*180/Math.PI); //angle in degrees
    if ( swipeAngle < 0 ) { swipeAngle =  360 - Math.abs(swipeAngle); }
  }

  function determineSwipeDirection() {
    if ( (swipeAngle <= 45) && (swipeAngle >= 0) ) {
      swipeDirection = 'left';
    } else if ( (swipeAngle <= 360) && (swipeAngle >= 315) ) {
      swipeDirection = 'left';
    } else if ( (swipeAngle >= 135) && (swipeAngle <= 225) ) {
      swipeDirection = 'right';
    } else if ( (swipeAngle > 45) && (swipeAngle < 135) ) {
      swipeDirection = 'down';
    } else {
      swipeDirection = 'up';
    }
  }

  function processingRoutine() {
    var swipedElement = document.getElementById(triggerElementID);
    if ( swipeDirection == 'left' ) {
      goLeft();
    } else if ( swipeDirection == 'right' ) {
      goRight();
    } else if ( swipeDirection == 'up' ) {
      goUp();
    } else if ( swipeDirection == 'down' ) {
      goDown();
    }
  }
  
    // need to put in similar to detect swipes
  $("#question").on({"touchstart": function(event) {
    // disable the standard ability to select the touched object
    event.preventDefault();
    // get the total number of fingers touching the screen
    fingerCount = event.originalEvent.touches.length;
    // since we're looking for a swipe (single finger) and not a gesture (multiple fingers),
    // check that only one finger was used
    if ( fingerCount == 1 ) {
      // get the coordinates of the touch
      startX = event.originalEvent.touches[0].pageX;
      startY = event.originalEvent.touches[0].pageY;
    } else {
      // more than one finger touched so cancel
      touchCancel();
    }
  }
  });
  
  $("#question").on({"touchend": function(event) {
    
    // check to see if more than one finger was used and that there is an ending coordinate
    if ( fingerCount == 1 && curX != 0 ) {
      // use the Distance Formula to determine the length of the swipe
      swipeLength = Math.round(Math.sqrt(Math.pow(curX - startX,2) + Math.pow(curY - startY,2)));
      // if the user swiped more than the minimum length, perform the appropriate action
      if ( swipeLength >= minLength ) {
        calculateAngle();
        determineSwipeDirection();
        processingRoutine();
        touchCancel(); // reset the variables
        event.preventDefault();
      } else {
        document.elementFromPoint(curX,curY).click();
        touchCancel();
        
      } 
    } else {
      document.elementFromPoint(curX,curY).click();
      touchCancel();
      event.preventDefault();
    }
  }
  });
  
  $("#question").on({"touchmove": function(event) {
    event.preventDefault();
    if ( event.originalEvent.touches.length == 1 ) {
      curX = event.originalEvent.touches[0].pageX;
      curY = event.originalEvent.touches[0].pageY;
    } else {
      touchCancel();
    }
  }
  });
  
  $("#question").on({"touchcancel": touchCancel});
  
});