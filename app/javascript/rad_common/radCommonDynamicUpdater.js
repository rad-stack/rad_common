export class RadCommonDynamicUpdater {
  static setup() {
    $(document).ready( function() {
      $('form.dynamic-updater input').change(function() {
        var form = $(this).closest('form');
        var url = form.attr('action') + '.json';
        var data = $(this).closest('form').serializeArray();
        $.post(url, data)
          .fail(function(data) {
            alert(data.responseJSON.error);
            form[0].reset();
          });
      });

      $('.select-all-settings, .select-none-settings').click(function(e) {
        e.preventDefault();
        var field = $(this).data('field');
        var checked = $(this).hasClass('select-all-settings');

        $('form.dynamic-updater').each(function() {
          var checkbox = $(this).find('input[type="checkbox"][id*="_' + field + '_"]');
          if (checkbox.length && !checkbox.prop('disabled') && checkbox.prop('checked') !== checked) {
            checkbox.prop('checked', checked);
            checkbox.trigger('change');
          }
        });
      });
    });
  }
}
