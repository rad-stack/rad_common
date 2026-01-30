import { Controller } from '@hotwired/stimulus';
import TomSelect from 'tom-select';

export default class extends Controller {
  static targets = ['scope', 'input', 'superSearch'];
  static values = { initialScope: Object };

  connect() {
    this.initializeTomSelect();
  }

  setScope(event) {
    event.preventDefault();
  
    const newScope = event.currentTarget.dataset.searchScope;
  
    this.scopeTarget.value = newScope;
    const tomSelect = this.inputTarget.tomselect;
    tomSelect.clearOptions();
    tomSelect.clear();
    tomSelect.settings.placeholder = event.currentTarget.textContent;
    tomSelect.inputState();
    this.inputTarget.dataset.globalSearchScope = newScope;
    setTimeout(() => {
      tomSelect.focus();
    }, 100);
  }

  toggleSuperSearch() {
    const tomSelect = this.inputTarget.tomselect;
    if (this.superSearchTarget.checked) {
      if (!window.confirm('Are you sure you want to do a super (combined) search? This query may take a long time, selecting a normal query is preferred to get your results quickly and not bog down the system.')) {
        this.superSearchTarget.checked = false;
        return;
      }

      tomSelect.clear();
      tomSelect.clearOptions();
      tomSelect.settings.placeholder = 'Super Search';
      this.inputTarget.dataset.globalSearchScope = '';
    } else {
      this.inputTarget.dataset.globalSearchScope = this.initialScopeValue.name;
      tomSelect.settings.placeholder = this.initialScopeValue.description;
    }

    tomSelect.inputState();
  }

  initializeTomSelect() {
    new TomSelect(this.inputTarget, {
      placeholder: this.inputTarget.dataset.placeholder || 'Start typing to search',
      valueField: 'id',
      labelField: 'label',
      searchField: [],
      allowEmptyOption: false,
      create: false,
      closeAfterSelect: true,

      load: function(query, callback) {
        if (!query.length) return callback();

        const searchScope = this.input.dataset.globalSearchScope || '';
        const superSearch = document.querySelector('.super_search')?.checked ? 'true' : 'false';

        const params = new URLSearchParams({
          term: query,
          global_search_scope: searchScope,
          super_search: superSearch
        });

        fetch(`/global_search?${params.toString()}`, {
          method: 'GET',
          headers: { 'Accept': 'application/json' }
        })
          .then((response) => response.json())
          .then((data) => {
            this.clearOptions();
            this.clear();

            const results = data.map((item) => ({
              ...item,
              subtext: item.columns ? item.columns.filter((item) => !!item).join(' | ') : null,
              globalSearchUrl: '/global_search_result?' + new URLSearchParams({
                global_search_name: item.label,
                global_search_id: item.id,
                global_search_model_name: item.model_name,
                global_search_scope: searchScope
              }).toString()
            }));
            callback(results);
          })
          .catch((e) => {
            callback();
          });
      },

      render: {
        option: function(item, escape) {
          const label = escape(item.label || '');
          const subtext = item.subtext
            ? `<small class="text-muted">${escape(item.subtext)}</small>`
            : '';
          const url = escape(item.globalSearchUrl || '#');

          return `
          <div>
            <a href="${url}" class="${item.active ? 'text-dark' : 'text-danger'}">
              <div>${label}</div>
              ${subtext ? subtext : ''}
            </a>
          </div>
        `;
        },

        item: function(item, escape) {
          const label = escape(item.label || '');
          return `<div>${label}</div>`;
        }
      },

      onChange: function(value) {
        const selected = this.options[value];
        if (selected && selected.globalSearchUrl) {
          window.location.href = selected.globalSearchUrl;
        }
      }
    });
  }
}
