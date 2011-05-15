/* DO NOT MODIFY. This file was compiled Sat, 14 May 2011 19:36:59 GMT from
 * /home/alexd/www/bluey/app/coffeescripts/controllers/plans.coffee
 */

(function() {
  var updatePlanDays, updatePlanItems;
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
  updatePlanItems = function() {
    $('.plan-item input[type=checkbox]:checked').closest('li').addClass('completed');
    return $('.plan-item input[type=checkbox]:not(:checked)').closest('li').removeClass('completed');
  };
  $(document).ready(function() {
    $('#new_plan').bind('nested:fieldAdded', updatePlanDays).bind('nested:fieldRemoved', updatePlanDays);
    $('#add-day').click(function(event) {
      var content;
      content = $('.plan-day').clone();
      content.find('span').text('Day ' + ($('.plan-day').length + 1));
      content.find('.fields').remove();
      $(this).parent().before('<div class="plan-day">' + $(content).html() + '</div>');
      return event.preventDefault();
    });
    updatePlanItems();
    $('.plan-item input[type=checkbox]').click(function() {
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
    $('li.plan-item section').hide();
    return $('<a href="#">Show metrics</a>').prependTo('li.plan-item section').click(function(event) {
      var link;
      link = $(this);
      $(this).parent().find('section').toggle('fast', function() {
        if ($(this).is(':visible')) {
          return link.text('Hide metrics');
        } else {
          return link.text('Show metrics');
        }
      });
      return event.preventDefault();
    });
  });
}).call(this);
