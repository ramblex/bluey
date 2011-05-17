updatePlanDays = ->
  $('.plan-day:visible').each (idx) ->
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

  $('.plan-item input[type=checkbox]').click ->
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

  $('li.plan-item section').hide()
  $('<a href="#">Show metrics</a>')
    .prependTo('li.plan-item section')
    .click (event) ->
      link = $(this)
      $(this).parent().find('section').toggle('fast', ->
        if $(this).is(':visible')
          link.text('Hide metrics')
        else
          link.text('Show metrics')
      )
      event.preventDefault()
