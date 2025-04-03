class SearchableAssociationInput < SimpleForm::Inputs::CollectionSelectInput
  include RadCommon::SearchableDropdownHelper

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
      if search_only?
        input_html_options.merge!(searchable_scope_options(show_subtext: options[:show_subtext],
                                                           search_scope: options[:search_scope],
                                                           excluded_ids: options[:excluded_ids]))
      else
        input_html_options[:class].push(:selectpicker)
      end
      options[:include_blank] = 'None' if options[:include_blank].nil?
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
      options[:search_only] || max_dropdown_size_exceeded?(records)
    end

    def global_autocomplete
      @global_autocomplete ||= GlobalAutocomplete.new(global_autocomplete_params,
                                                      GlobalSearch.new(current_user, :searchable_association).scopes,
                                                      current_user,
                                                      :searchable_association)
    end

    def global_autocomplete_params
      { limit: max_dropdown_size, global_search_scope: options[:search_scope], excluded_ids: options[:excluded_ids] }
    end

    def selected_search_option
      selected = input_options[:selected]
      object.present? ? object.public_send(reflection.name) : (selected.presence && records.find(selected))
    end
end
