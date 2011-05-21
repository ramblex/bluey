updatePlanDays = ->
  $('.day:visible').each (idx) ->
    day = idx + 1
    $(this).find('span').text('Day ' + day)
    $(this).find('input[id$=_day]').attr('value', day)
    $(this).find('.fields').each (pos) ->
      $(this).find('input[id$=_position]').attr('value', pos)

updatePlanItems = ->
  $('.plan-item input[type=checkbox]:checked').closest('li').addClass('completed')
  $('.plan-item input[type=checkbox]:not(:checked)').closest('li').removeClass('completed')

$(document).ready ->
  $('#new_plan')
    .bind('nested:fieldAdded', updatePlanDays)
    .bind('nested:fieldRemoved', updatePlanDays)

  updatePlanItems()

  $('.plan-item header input[type=checkbox]').click ->
    $.ajax
      url: '/plan_items/'+$(this).attr('value')
      type: 'put'
      data:
        plan_item:
          completed: $(this).is(':checked')
        authenticity_token: $('meta[name=csrf-token]').attr('content')
      success: ->
        updatePlanItems()
      error: ->
        console.log('Error')
  scanMetrics()
