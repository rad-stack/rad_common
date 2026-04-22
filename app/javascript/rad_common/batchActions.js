import bootstrap from 'bootstrap';

export class BatchActions {
  static setup() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('.batch-action-tooltip')).map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  
    const enableDropdown = () => {
      if (document.getElementById('batch-action-dropdown')) {
        document.getElementById('batch-action-dropdown').classList.remove('disabled');
      }
      tooltipTriggerList.forEach(function(tooltip) {
        tooltip.disable();
      });
    };

    const disableDropdown = () => {
      if (document.getElementById('batch-action-dropdown')) {
        document.getElementById('batch-action-dropdown').classList.add('disabled');
      }
      tooltipTriggerList.forEach(function(tooltip) {
        tooltip.enable();
      });
    };

    // Initial page load
    if (Array.from(document.querySelectorAll('.bulk-action-checkbox')).some((cb) => cb.checked)) {
      enableDropdown();
    }

    const selectAllElement = document.getElementById('batch_action_select_all');
    if (selectAllElement) {
      selectAllElement.addEventListener('click', function() {
        const isChecked = this.checked;
        if (isChecked) {
          enableDropdown();
        } else {
          disableDropdown();
        }

        document.querySelectorAll('.bulk-action-checkbox').forEach(function(checkbox) {
          checkbox.checked = isChecked;
        });
      });
    }
  
    const bulkActionElements = document.querySelectorAll('.bulk-action-checkbox');
    if (bulkActionElements) {
      document.querySelectorAll('.bulk-action-checkbox').forEach(function(checkbox) {
        checkbox.addEventListener('click', function() {
          const allDeselected = Array.from(document.querySelectorAll('.bulk-action-checkbox')).every(function(cb) {
            return !cb.checked;
          });

          if (this.checked) {
            enableDropdown();
            if (Array.from(document.querySelectorAll('.bulk-action-checkbox')).every(function(cb) {
              return cb.checked;
            })) {
              document.getElementById('batch_action_select_all').checked = true;
            }
          } else {
            document.getElementById('batch_action_select_all').checked = false;
            if (allDeselected) {
              disableDropdown();
            }
          }
        });
      });
    }
  }
}
