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

  scanMetrics = ->
    if ($(this).parent().find('.found').length == 0)
      $(this).parent().append('<span class="found" />')
    matches = $(this).attr('value').match(/([\d\.]+)\s*(\S[^,0-9]+)/g)
    if (matches isnt null)
      found = $(this).parent().find('.found')
      found.html('Found: ')
      found.append('<span>'+value+'</span>') for value in matches
    else
      $(this).parent().remove('.found')

  $('.add-exercise').bind 'ajax:complete', ->
    $('input[id$=_measurements]').keyup(scanMetrics)
    $('#new_plan_item').bind 'nested:fieldAdded', ->
      $('input[id$=_measurements]').keyup(scanMetrics)
