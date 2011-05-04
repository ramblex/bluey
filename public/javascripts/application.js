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

  // Dialog forms
  $('.dialog').click(function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
      autoOpen: false,
      width: 360,
      modal: true,
      open: function() {
        $(this).load(url+' #content');
      }
    });
    dialog_form.dialog('open');
  });

  $('#profile-picture').click(function(e) {
    $('#user-tabs li a[name="pictures"]').click();
  });

  $('#notifications').delay(5000).fadeOut(2000);

  $('.user-form').hide();
  $('#foundation.user-form').show();

  // User profile tabs
  $('#user-tabs li a').click(function(e) {
    var form_name = $(this).attr('name');
    $('#user-tabs li').removeClass('selected');
    $(this).parent('li').addClass('selected');
    $('.user-form').hide();
    var href = $(this).attr('href');
    if (href === "") {
      $('#'+form_name).show();
    } else {
      $('#loaded-form').show().html('Loading form...');
      $('#loaded-form').load(href + ' #load', function() {
        if (href === "/user_goals") {
          // Body goals
          $('.person li[name=General]').attr('id', 'general');
          $('.body-part-form').hide();
          $('.body-part-form:first').show();
          $('input[id$=goal_value]').each(function() {
            var fieldset = $(this).closest('fieldset');
            if ($('input:checked', fieldset).length > 0) {
              $(this).parent().show();
            } else {
              $(this).parent().hide();
            }
          });

          $('input[id$=is_goal]').click(function() {
            var fieldset = $(this).closest('fieldset');
            var nearest_goal = $('input[id$=goal_value]', fieldset).parent();
            if ($(this).is(':checked')) {
              nearest_goal.show();
            } else {
              nearest_goal.hide();
            }
          });
          $('.person li a').click(function(e) {
            e.preventDefault();
          });
          $('.person li').click(function() {
            var form_name = $(this).attr('name');
            $('.body-part-form').hide();
            $('.body-part-form[name="'+form_name+'"]').show();
            $('.person li').removeClass('selected');
            $(this).addClass('selected');
          });
          $('.person li:first').addClass('selected');
        }
      });
    }
    e.preventDefault();
  });

  // Plan days
  function updatePlanDays() {
    $('.plan-day').each(function(idx) {
      var day = (idx + 1);
      $(this).find('span').text('Day ' + day);
      $('input:first', this).attr('value', day);
    });
  }

  $('#new_plan')
    .bind('nested:fieldAdded', updatePlanDays)
    .bind('nested:fieldRemoved', updatePlanDays);

});
