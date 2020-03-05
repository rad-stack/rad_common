$(document).ready( function() {
    $('form.dynamic-updater input').change(function() {
        let form = $(this).closest('form')
        let url = form.attr('action') + ".json";
        let data = $(this).closest('form').serializeArray();
        $.post(url, data)
            .fail(function(data) {
                alert(data.responseJSON.error);
                form[0].reset();
            });
    });
});