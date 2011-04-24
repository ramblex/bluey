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

  $('#notifications').fadeOut(5000);
});
