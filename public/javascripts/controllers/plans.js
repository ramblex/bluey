/* DO NOT MODIFY. This file was compiled Wed, 25 May 2011 18:34:55 GMT from
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
    var scanMetrics;
    $('#new_plan').bind('nested:fieldAdded', updatePlanDays).bind('nested:fieldRemoved', updatePlanDays);
    updatePlanItems();
    $('.plan-item header input[type=checkbox]').click(function() {
      return $.ajax({
        url: $(this).attr('data-url'),
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
    scanMetrics = function() {
      var found, matches, value, _i, _len, _results;
      if ($(this).parent().find('.found').length === 0) {
        $(this).parent().append('<span class="found" />');
      }
      matches = $(this).attr('value').match(/([\d\.]+)\s*(\S[^,0-9]+)/g);
      if (matches !== null) {
        found = $(this).parent().find('.found');
        found.html('Found: ');
        _results = [];
        for (_i = 0, _len = matches.length; _i < _len; _i++) {
          value = matches[_i];
          _results.push(found.append('<span>' + value + '</span>'));
        }
        return _results;
      } else {
        return $(this).parent().remove('.found');
      }
    };
    return $('.add-exercise').bind('ajax:complete', function() {
      $('input[id$=_measurements]').keyup(scanMetrics);
      return $('#new_plan_item').bind('nested:fieldAdded', function() {
        return $('input[id$=_measurements]').keyup(scanMetrics);
      });
    });
  });
}).call(this);
