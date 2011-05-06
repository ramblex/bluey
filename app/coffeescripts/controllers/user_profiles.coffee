$(document).ready ->
  $('#profile-picture').click (event) ->
    $('#user-tabs li a[name="pictures"]').click()

  $('.user-form').hide()
  $('#foundation.user-form').show()

  # User profile abs
  $('#user-tabs li a').click (event) ->
    form_name = $(this).attr('name')
    $('#user-tabs li').removeClass('selected')
    $(this).parent('li').addClass('selected')
    $('.user-form').hide()
    href = $(this).attr('href')
    if href
      $('#loaded-form').show().html('Loading form...')
      $('#loaded-form').load href + ' #load', ->
        if href is "/user_goals"
          $('.person li[name=General]').attr('id', 'general')
          $('.body-part-form').hide()
          $('.body-part-form:first').show()
          # Hide goal input if stat is not a goal
          $('input[id$=goal_value]').each ->
            fieldset = $(this).closest('fieldset')
            if $('input:checked', fieldset).length > 0
              $(this).parent().show()
            else
              $(this).parent().hide()

          # Allow stats to be made goals or not
          $('input[id$=is_goal]').click ->
            fieldset = $(this).closest('fieldset')
            nearest_goal = fieldset.find('input[id$=goal_value]').parent()
            if $(this).is(':checked')
              nearest_goal.show()
            else
              nearest_goal.hide()

          # Switching between body parts
          $('.person li a').click (event) ->
            event.preventDefault()

          $('.person li').click ->
            form_name = $(this).attr('name')
            $('.body-part-form').hide()
            $(".body-part-form[name='#{form_name}']").show()
            $('.person li').removeClass('selected')
            $(this).addClass('selected');
          $('.person li:first').addClass('selected')
    else
      $("##{form_name}").show()
    event.preventDefault()


