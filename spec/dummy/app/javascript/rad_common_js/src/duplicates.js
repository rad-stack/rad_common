export class Duplicates {
    static setup() {
        if($('#duplicate-toast').length) {
            $('.duplicate-card').hide();
            Duplicates.checkForDuplicates();
            let form = $('form.simple_form');
            form.find('input').not('#create-anyway').change(function() {
                Duplicates.checkForDuplicates();
            });

            $('#create-anyway').change(function() {
                let disabled = !$(this).prop('checked');
                Duplicates.toggleSave(disabled);
            });
        }
    }

    static checkForDuplicates() {
        let modelName = this.duplicateModel().replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
        let form = $(`#new_${modelName}`);
        let data = Duplicates.convertFormToJSON(form, modelName);
        $.ajax({
            type: 'POST',
            url: '/duplicates/check_duplicate',
            data: { record: data, model: Duplicates.duplicateModel() },
            success: function(data) {
                Duplicates.processDuplicateData(data);
            },
            dataType: 'json'
        });
    }

    static duplicateModel() {
        let duplicateData = $('#duplicate-toast').data();
        return duplicateData.model;
    }

    static toggleSave(disabled) {
        let form = $('form.simple_form');
        form.find('input[type=submit]').prop('disabled', disabled);
    }

    static processDuplicateData(data) {
        if(data.duplicate) {
            $('.toast').toast('show');
            this.buildDuplicateTable(data);
            $('#duplicate-toast-header').html(`${this.duplicateModel()} May Already Exist`);
            $('#create-anyway-label').html(`This is not a duplicate ${this.duplicateModel()}. Save as new record?`);
            $('.duplicate-card').show();
            this.toggleSave(true);
            $('.card-body').addClass('duplicate-body');
        } else {
            $('.toast').toast('hide');
            $('.duplicate-card').hide();
            $('.card-body').removeClass('duplicate-body');
        }
    }

    static buildDuplicateTable(data) {
        let html = '<table class=\'table\'>';
        let first = data.duplicates[0].duplicate_data;
        html += '<tr>';
        Object.keys(first).forEach(field => {
            html += `<th>${field}</th>`;
        });
        html += '<th>Actions</th>';
        html += '</tr>';
        data.duplicates.forEach(duplicate => {
            html += '<tr>';
            Object.values(duplicate.duplicate_data).forEach(value => {
                html += `<td>${value || ''}</td>`;
            });
            html += `<td><a href='${duplicate.duplicate_path}' class='btn btn-sm btn-warning' target='_blank'>View Matches</a></td>`;
            html += '</tr>';
        });
        html += '</table>';
        $('.duplicate-card .duplicate-data').html(html);
    }

    static convertFormToJSON(form, modelName) {
      let formData = $(form).serializeArray();
      let json = {};

      formData.forEach(({ name, value }) => {
        name = name.replace(`${modelName}[`, '').replace(/\]$/, '');
        if (name.endsWith('[]')) {
          name = name.slice(0, -2);
          if (!json[name]) {
            json[name] = [];
          }
          json[name].push(value);
        } else {
          json[name] = value;
        }
      });

      return json;
    }
}
