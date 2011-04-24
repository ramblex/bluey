$(document).ready(function() {

    $('.on_the_spot_editing').hover(function() {
      $(this).css('background-color', '#fffcc3');
    },
    function() {
      $(this).css('background-color', 'inherit');
    });
    $('.on_the_spot_editing').each(function(n){
        var el           = $(this),
            data_url     = el.attr('data-url'),
            ok_text      = el.attr('data-ok') || 'Save',
            cancel_text  = el.attr('data-cancel') || 'Cancel',
            tooltip_text = el.attr('data-tooltip') || 'click to edit ...',
            edit_type    = el.attr('data-edittype'),
            select_data  = el.attr('data-select'),
            rows         = el.attr('data-rows'),
            columns      = el.attr('data-columns'),
            load_url     = el.attr('data-loadurl');

        var options = {
            tooltip: tooltip_text,
            placeholder: tooltip_text,
            cancel: cancel_text,
            submit: ok_text,
            onblur: 'ignore',
            onerror: function (settings, original, xhr) {
                original.reset();
                //just show the error-msg for now
                alert(xhr.responseText);
            }
        };
        if (edit_type != null) {
            options.type = edit_type;
        }
        if (edit_type == 'select') {
            if (select_data != null) {
                options.data = select_data;
                options.submitdata = { 'select_array': select_data }
            }
            if (load_url != null) {
                options.loadurl = load_url;
            }
        }
        else if (edit_type == 'textarea') {
            options.rows = rows;
            options.cols = columns;
        }

        el.editable(data_url, options)
    })

});
