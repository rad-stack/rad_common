class SearchableAssociationInput < SimpleForm::Inputs::CollectionSelectInput
  MAX_DROPDOWN_SIZE = 300

  def input(wrapper_options = nil)
    search_field = options[:search_only] || options[:collection].size > MAX_DROPDOWN_SIZE
    options[:collection] = search_field ? [object.public_send(reflection.name)].compact : options[:collection]
    label_method, value_method = detect_collection_methods
    input_html_options[:class].push(:selectpicker)
    opts = input_html_options.merge('data-live-search' => true)
    if search_field
      opts.merge!(search_options)
      options[:include_blank] = false
    end
    merged_input_options = merge_wrapper_options(opts, wrapper_options)
    @builder.collection_select(attribute_name, collection, value_method, label_method,
                               input_options, merged_input_options)
  end

  private

    def search_options
      {
        class: 'selectpicker-search',
        'data-abs-template' => { clear_option: 'None' }.to_json,
        'data-abs-subtext' => options[:show_subtext],
        'data-abs-ajax-data' => {
          'global_search_scope' => options[:search_scope],
          'term' => '{{{q}}}'
        }.to_json
      }
    end
end
