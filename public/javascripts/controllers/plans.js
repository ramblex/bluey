/* DO NOT MODIFY. This file was compiled Sat, 21 May 2011 19:26:00 GMT from
 * /Users/alexduller/www/bluey/app/coffeescripts/controllers/plans.coffee
 */

(function() {
  var updatePlanDays, updatePlanItems;
  updatePlanDays = function() {
    return $('.day:visible').each(function(idx) {
      var day;
      day = idx + 1;
      $(this).find('span').text('Day ' + day);
      $(this).find('input[id$=_day]').attr('value', day);
      return $(this).find('.fields').each(function(pos) {
        return $(this).find('input[id$=_position]').attr('value', pos);
      });
    });
  };
  updatePlanItems = function() {
    $('.plan-item input[type=checkbox]:checked').closest('li').addClass('completed');
    return $('.plan-item input[type=checkbox]:not(:checked)').closest('li').removeClass('completed');
  };
  $(document).ready(function() {
    $('#new_plan').bind('nested:fieldAdded', updatePlanDays).bind('nested:fieldRemoved', updatePlanDays);
    updatePlanItems();
    $('.plan-item header input[type=checkbox]').click(function() {
      return $.ajax({
        url: '/plan_items/' + $(this).attr('value'),
        type: 'put',
        data: {
          plan_item: {
            completed: $(this).is(':checked')
          },
          authenticity_token: $('meta[name=csrf-token]').attr('content')
        },
        success: function() {
          return updatePlanItems();
        },
        error: function() {
          return console.log('Error');
        }
      });
    });
    return scanMetrics();
  });
}).call(this);
