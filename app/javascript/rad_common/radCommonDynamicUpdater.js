import * as bootstrap from 'bootstrap';

export class RadCommonDynamicUpdater {
  static setup() {
    $(document).ready( function() {
      $('form.dynamic-updater input').change(function() {
        var form = $(this).closest('form');
        var url = form.attr('action') + '.json';
        var data = $(this).closest('form').serializeArray();
        var input = $(this);
        $.post(url, data)
          .done(function() {
            if (input.attr('id') && input.attr('id').match(/^notification_setting_enabled_/)) {
              input.closest('tr').toggleClass('table-danger', !input.prop('checked'));
              var target = input.attr('data-bs-target');
              if (target) {
                var collapseEl = document.querySelector(target);
                if (collapseEl) {
                  var collapse = bootstrap.Collapse.getInstance(collapseEl);
                  if (!collapse) {
                    collapse = new bootstrap.Collapse(collapseEl, { toggle: false });
                  }
                  input.prop('checked') ? collapse.show() : collapse.hide();
                }
              }
            }
            updateBulkCheckboxStates();
          })
          .fail(function(data) {
            alert(data.responseJSON.error);
            form[0].reset();
          });
      });

      function updateBulkCheckboxStates() {
        $('.bulk-setting-checkbox').each(function() {
          var field = $(this).data('field');
          var checkboxes = $('form.dynamic-updater input[type="checkbox"][id*="_' + field + '_"]').not(':disabled');
          if (checkboxes.length === 0) return;
          var checkedCount = checkboxes.filter(':checked').length;
          this.checked = checkedCount > 0;
          this.indeterminate = checkedCount > 0 && checkedCount < checkboxes.length;
        });
      }

      updateBulkCheckboxStates();

      $('.bulk-setting-checkbox').change(function() {
        if (!confirm('Are you sure?')) {
          $(this).prop('checked', !$(this).prop('checked'));
          return;
        }
        var field = $(this).data('field');
        var checked = $(this).prop('checked');

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
