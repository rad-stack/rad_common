import $ from 'jquery'

export class RadCommonDynamicUpdater {
    static setup() {
        $(document).ready( function() {
            $('form.dynamic-updater input').change(function() {
                var form = $(this).closest('form')
                var url = form.attr('action') + ".json";
                var data = $(this).closest('form').serializeArray();
                $.post(url, data)
                    .fail(function(data) {
                        alert(data.responseJSON.error);
                        form[0].reset();
                    });
            });
        });
    }
}
