/* DO NOT MODIFY. This file was compiled Thu, 26 May 2011 17:27:08 GMT from
 * /Users/alexduller/www/bluey/app/coffeescripts/application.coffee
 */

(function() {
  var animate_progress;
  animate_progress = function(meter_idx, percentage, append_hint) {
    var hint, meter, stick;
    meter = $(".meter:eq(" + meter_idx + ")");
    stick = $(meter).find('img');
    stick.rotate(-180);
    stick.rotate({
      animateTo: ((percentage / 100) * 180) - 180
    });
    if (append_hint) {
      hint = $("<div class=\"hint\">" + percentage + "%</div>");
      meter.append(hint);
      return meter.hover(function() {
        return hint.fadeIn();
      }, function() {
        return hint.fadeOut();
      });
    }
  };
  $(document).ready(function() {
    animate_progress(0, 30, true);
    animate_progress(1, 50, false);
    $('.dialog').click(function(event) {
      var dialog_form, url;
      event.preventDefault();
      url = $(this).attr('href');
      dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
        autoOpen: false,
        width: 360,
        modal: true,
        open: function() {
          return $(this).load(url + ' #content');
        }
      });
      return dialog_form.dialog('open');
    });
    $('#notifications').delay(5000).fadeOut(2000);
    return $('a[data-remote="true"]').click(function() {
      var original;
      original = $(this).html();
      return $(this).html('Loading...').bind('ajax:complete', function() {
        return $(this).html(original);
      });
    });
  });
}).call(this);
