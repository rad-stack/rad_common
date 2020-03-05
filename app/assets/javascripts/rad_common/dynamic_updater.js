$(document).ready( function() {
    $('form.dynamic-updater input').change(function() {
        let url = $(this).closest('form').attr('action') + ".json";
        let data = $(this).closest('form').serializeArray();
        $.post(url, data)
            .fail(function(data) {
                addAlert('danger', data.responseJSON.error)
            });
    });

    function addAlert(type, message) {
        $('.card-body').prepend( $("<div class='alert alert-" + type + "'>" + message + "</div>") )
    }
});