# meter_idx: Index of the meter to animate
# percentage: Percentage progress for the meter
# append_hint: Whether to append a div.hint which contains the percentage
animate_progress = (meter_idx, percentage, append_hint) ->
  meter = $(".meter:eq(#{meter_idx})")
  stick = $(meter).find('img')
  stick.rotate(-180)
  stick.rotate({animateTo: ((percentage / 100) * 180) - 180})
  if append_hint
    hint = $("<div class=\"hint\">#{percentage}%</div>")
    meter.append(hint)
    meter.hover ->
      hint.fadeIn()
    , ->
      hint.fadeOut()

$(document).ready ->
  animate_progress(0, 30, true)
  animate_progress(1, 50, false)

  # Dialog forms
  $('.dialog').click (event) ->
    event.preventDefault()
    url = $(this).attr('href')
    dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog
      autoOpen: false,
      width: 360,
      modal: true,
      open: -> $(this).load(url+' #content');
    dialog_form.dialog('open')

  # Notifications
  $('#notifications').delay(5000).fadeOut(2000)

  $('a[data-remote="true"]').click ->
    original = $(this).html()
    $(this).html('Loading...').bind('ajax:complete', -> $(this).html(original))
