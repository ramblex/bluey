updatePlanDays = ->
  $('.plan-day:visible').each (idx) ->
    day = idx + 1
    $(this).find('span').text('Day ' + day)
    $(this).find('input[id$=_day]').attr('value', day)
    $(this).find('.fields').each (pos) ->
      $(this).find('input[id$=_position]').attr('value', pos)

updatePlanItems = ->
  $('.plan-item input[type=checkbox]:checked').parent().addClass('completed')
  $('.plan-item input[type=checkbox]:not(:checked)').parent().removeClass('completed')

$(document).ready ->
  $('#new_plan')
    .bind('nested:fieldAdded', updatePlanDays)
    .bind('nested:fieldRemoved', updatePlanDays)

  $('#add-day').click (event) ->
    content = $('.plan-day').clone() # Day template
    content.find('span').text('Day ' + ($('.plan-day').length + 1))
    content.find('.fields').remove()
    $(this).parent().before('<div class="plan-day">'+$(content).html()+'</div>')
    event.preventDefault()

  updatePlanItems()

  $('.plan-item input[type=checkbox]').click ->
    console.log('Completed item '+$(this).attr('value'))
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
      complete: ->
        console.log('Complete')
