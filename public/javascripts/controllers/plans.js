/* DO NOT MODIFY. This file was compiled Fri, 06 May 2011 20:01:29 GMT from
 * /Users/alexduller/www/bluey/app/coffeescripts/controllers/plans.coffee
 */

(function() {
  var updatePlanDays;
  updatePlanDays = function() {
    return $('.plan-day:visible').each(function(idx) {
      var day;
      day = idx + 1;
      $(this).find('span').text('Day ' + day);
      $(this).find('input[id$=_day]').attr('value', day);
      return $(this).find('.fields').each(function(pos) {
        return $(this).find('input[id$=_position]').attr('value', pos);
      });
    });
  };
  $(document).ready(function() {
    $('#new_plan').bind('nested:fieldAdded', updatePlanDays).bind('nested:fieldRemoved', updatePlanDays);
    return $('#add-day').click(function(event) {
      var content;
      content = $('.plan-day').clone();
      content.find('span').text('Day ' + ($('.plan-day').length + 1));
      content.find('.fields').remove();
      $(this).parent().before('<div class="plan-day">' + $(content).html() + '</div>');
      return event.preventDefault();
    });
  });
}).call(this);
