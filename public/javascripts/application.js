// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function animate_progress(meter_id, percentage) {
  var bar = $('.progress:eq('+meter_id+')');
  bar.animate({width: percentage + '%'}, 'slow');
}

$(document).ready(function() {
  animate_progress(0, 30);
  animate_progress(1, 50);
});
