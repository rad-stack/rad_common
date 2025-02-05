export class BatchActions {
  static setup() {
    $('.batch-action-tooltip').tooltip();
    const enableDropdown = () => {
      $('#batch-action-dropdown').removeClass('disabled');
      $('.batch-action-tooltip').tooltip('disable');
    }
    const disableDropdown = () => {
      $('#batch-action-dropdown').addClass('disabled');
      $('.batch-action-tooltip').tooltip('enable');
    }

    // Initial page load
    if ($('.bulk-action-checkbox').toArray().some((cb) => cb.checked)) {
      enableDropdown();
    }
  
    $('#batch_action_select_all').click(function() {
      let is_checked;
      is_checked = $(this).is(':checked');
      if (is_checked) {
        enableDropdown();
      } else {
        disableDropdown();
      }
      return $('.bulk-action-checkbox').each(function() {
        return $(this).prop('checked', is_checked);
      });
    });
    return $('.bulk-action-checkbox').click(function() {
      let all_deselected;
      if ($(this).is(':checked')) {
        enableDropdown();
        if ($('.bulk-action-checkbox').toArray().every(function(cb) {
          return cb.checked;
        })) {
          return $('#batch_action_select_all').prop('checked', true);
        }
      } else {
        $('#batch_action_select_all').prop('checked', false);
        all_deselected = $('.bulk-action-checkbox').toArray().every(function(cb) {
          return !cb.checked;
        });
        if (all_deselected) {
          disableDropdown();
        }
      }
    });
  }
}
