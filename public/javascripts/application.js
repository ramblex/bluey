// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function animate_progress(meter_id, percentage, append) {
  var meter = $('.meter:eq('+meter_id+')');
  var stick =  $('img', meter);
  stick.rotate(-180);
  stick.rotate({animateTo: ((percentage / 100) * 180) - 180});
  var hint = $('<div class="hint">'+percentage+'%</div>');
  if (append === true) {
    meter.append(hint);
    meter.hover(function() {
      hint.fadeIn();
    },
    function() {
      hint.fadeOut();
    });
  }
}

$(document).ready(function() {
  animate_progress(0, 30, true);
  animate_progress(1, 50, false);

  var sign_up_form = $('<div id="sign-up-form">Loading form...</div>').dialog({
    autoOpen: false,
    width: 360,
    modal: true,
    open: function() {
      $(this).load('/users/sign_up #content');
    }
  });

  $('#sign-up').click(function(e) {
    sign_up_form.dialog('open');
    e.preventDefault();
  })

  $('#notifications').delay(5000).fadeOut(2000);

  $('.user-form').hide();
  $('#foundation.user-form').show();

  // User profile tabs
  $('#user-tabs li a').click(function(e) {
    var form_name = $(this).attr('name');
    $('#user-tabs li').removeClass('selected');
    $(this).parent('li').addClass('selected');
    $('.user-form').hide();
    $('#'+form_name).show();
    e.preventDefault();
  });
});
