class SearchableAssociationInput < SimpleForm::Inputs::CollectionSelectInput
  MAX_DROPDOWN_SIZE = 300

  delegate :current_user, to: :template

  def input(wrapper_options = nil)
    options[:collection] = search_only? ? [selected_search_option].compact : searchable_collection
    label_method, value_method = detect_collection_methods
    add_default_options
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.collection_select(attribute_name, collection, value_method, label_method,
                               input_options, merged_input_options)
  end

  private

    def add_default_options
      input_html_options[:class].push(:selectpicker)
      input_html_options.merge!(
        'data-live-search' => true,
        'data-live-search-placeholder' => options[:search_placeholder].presence || 'Start typing to search'
      )
      return unless search_only?

      input_html_options.merge!(search_options)
      options[:include_blank] = false
    end

    def search_options
      {
        class: 'selectpicker-search',
        'data-abs-template' => { clear_option: 'None' }.to_json,
        'data-abs-subtext' => options[:show_subtext],
        'data-abs-locale-search-placeholder' => options[:search_placeholder],
        'data-abs-ajax-data' => {
          'global_search_scope' => options[:search_scope],
          'global_search_mode' => 'searchable_association',
          'excluded_ids' => options[:excluded_ids],
          'term' => '{{{q}}}'
        }.to_json
      }
    end

    def records
      @records ||= global_autocomplete.base_autocomplete_collection(global_autocomplete.current_scope)
    end

    def searchable_collection
      lambda {
        global_autocomplete.global_autocomplete_result.map do |r|
          [r[:label], r[:id], { 'data-subtext' => options[:show_subtext] ? r[:columns] : nil }]
        end
      }
    end

    def search_only?
      options[:search_only] || records.size > MAX_DROPDOWN_SIZE
    end

    def global_autocomplete
      @global_autocomplete ||= GlobalAutocomplete.new(global_autocomplete_params,
                                                      GlobalSearch.new(current_user, :searchable_association).scopes,
                                                      current_user,
                                                      :searchable_association)
    end

    def global_autocomplete_params
      { limit: MAX_DROPDOWN_SIZE, global_search_scope: options[:search_scope], excluded_ids: options[:excluded_ids] }
    end

    def selected_search_option
      selected = input_options[:selected]
      object.present? ? object.public_send(reflection.name) : (selected.presence && records.find(selected))
    end
end
