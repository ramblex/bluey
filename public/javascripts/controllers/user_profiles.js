/* DO NOT MODIFY. This file was compiled Fri, 06 May 2011 19:49:15 GMT from
 * /Users/alexduller/www/bluey/app/coffeescripts/controllers/user_profiles.coffee
 */

(function() {
  $(document).ready(function() {
    $('#profile-picture').click(function(event) {
      return $('#user-tabs li a[name="pictures"]').click();
    });
    $('.user-form').hide();
    $('#foundation.user-form').show();
    return $('#user-tabs li a').click(function(event) {
      var form_name, href;
      form_name = $(this).attr('name');
      $('#user-tabs li').removeClass('selected');
      $(this).parent('li').addClass('selected');
      $('.user-form').hide();
      href = $(this).attr('href');
      if (href) {
        $('#loaded-form').show().html('Loading form...');
        $('#loaded-form').load(href + ' #load', function() {
          if (href === "/user_goals") {
            $('.person li[name=General]').attr('id', 'general');
            $('.body-part-form').hide();
            $('.body-part-form:first').show();
            $('input[id$=goal_value]').each(function() {
              var fieldset;
              fieldset = $(this).closest('fieldset');
              if ($('input:checked', fieldset).length > 0) {
                return $(this).parent().show();
              } else {
                return $(this).parent().hide();
              }
            });
            $('input[id$=is_goal]').click(function() {
              var fieldset, nearest_goal;
              fieldset = $(this).closest('fieldset');
              nearest_goal = fieldset.find('input[id$=goal_value]').parent();
              if ($(this).is(':checked')) {
                return nearest_goal.show();
              } else {
                return nearest_goal.hide();
              }
            });
            $('.person li a').click(function(event) {
              return event.preventDefault();
            });
            $('.person li').click(function() {
              form_name = $(this).attr('name');
              $('.body-part-form').hide();
              $(".body-part-form[name='" + form_name + "']").show();
              $('.person li').removeClass('selected');
              return $(this).addClass('selected');
            });
            return $('.person li:first').addClass('selected');
          }
        });
      } else {
        $("#" + form_name).show();
      }
      return event.preventDefault();
    });
  });
}).call(this);
