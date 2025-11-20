import TomSelect from 'tom-select';

export class RadTomSelect {
  static setup(id) {
    const selector = id ? `#${id} select.selectpicker, #${id} input.selectpicker` : 'select.selectpicker,input.selectpicker';
    document.querySelectorAll(selector).forEach((el) => {
      if (el.tomselect) {
        return;
      }
      const plugins = ['dropdown_input'];
      if (el.multiple) {
        plugins.push('remove_button');
      }

      const initialPlaceholder = el.dataset.placeholder || 'Start typing to search';
      new TomSelect(el, {
        create: el.dataset.tsCreate === 'true',
        placeholder: initialPlaceholder,
        plugins,
        searchField: 'text',
        allowEmptyOption: !el.multiple,
        closeAfterSelect: !el.multiple,
        maxOptions: el.dataset.tsMaxOptions || null,
        onItemSelect: function () {
          this.refreshOptions(false);
          this.open();
          return false;
        },
        onDropdownOpen: function () {
          this.control_input.placeholder = 'Start typing to search';
        },
        onDropdownClose: function () {
          this.control_input.placeholder = initialPlaceholder;
        },
        onChange: function() {
          if (el.dataset.autosubmit === 'true') {
            const form = el.closest('form');
            if (form) {
              form.submit();
            }
          }
        },
        render: {
          option: function (item, escape) {
            const isInactive = el.querySelector(`option[value="${item.value}"]`)?.getAttribute('data-inactive') === 'true';
            const className = isInactive ? 'text-danger' : '';
            return `<div class="${className}">${escape(item.text)}</div>`;
          }
        }
      });
    });

    const selectpicker_selector = id ? `#${id} select.selectpicker-search,input.selectpicker-search` : 'select.selectpicker-search,input.selectpicker-search';
    document.querySelectorAll(selectpicker_selector).forEach((el) => {
      const plugins = ['dropdown_input'];
      if (el.multiple) {
        plugins.push('remove_button');
      }

      new TomSelect(el, {
        placeholder: 'Start typing to search',
        valueField: 'id',
        labelField: 'label',
        searchField: [],
        plugins,
        allowEmptyOption: true,
        create: false,

        load: function(query, callback) {
          if (!query.length) return callback();

          const searchScope = el.dataset.globalSearchScope || null;
          const excludedIds = el.dataset.excludedIds ? el.dataset.excludedIds.replaceAll(' ', ',') : '';
          const searchMode = el.dataset.globalSearchMode;

          const params = new URLSearchParams({
            term: query,
            global_search_scope: searchScope,
            global_search_mode: searchMode,
            excluded_ids: excludedIds
          });

          fetch(`/global_search?${params.toString()}`, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
          })
            .then(response => response.json())
            .then((data) => {
              this.clearOptions();
              this.clear();

              const results = data.map((item) => {
                return {
                  ...item,
                  subtext: item.columns ? item.columns.join(' ') : null
                };
              });

              if (!this.getValue()) {
                results.unshift({
                  id: '',
                  label: 'None',
                  subtext: null
                });
              }

              callback(results);
            })
            .catch(() => {
              callback();
            });
        },

        render: {
          option: function(item, escape) {
            const label = escape(item.label || '');
            const subtext = this.input.dataset.subtext === 'true' && item.subtext ?
              `<small class="text-muted">${escape(item.subtext)}</small>` :
              '';
            return `
              <div>
                <span class="${item.active ? '' : 'text-danger'}">${label}</span>
                ${subtext ? ' &mdash; ' + subtext : ''}
              </div>
            `;
          },
          item: function(item, escape) {
            return `<div>${escape(item.label || '')}</div>`;
          }
        }
      });
    });
  }
}
