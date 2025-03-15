class StateInput < SimpleForm::Inputs::GroupedCollectionSelectInput
  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods
    input_html_options[:class].push(:selectpicker)
    merged_input_options = merge_wrapper_options(input_html_options.merge('data-live-search' => true), wrapper_options)

    if RadConfig.canadian_addresses?
      @builder.grouped_collection_select(attribute_name, grouped_collection, group_method, group_label_method,
                                         value_method, label_method, input_options, merged_input_options)
    else
      @builder.collection_select(attribute_name, StateOptions.options, value_method, label_method,
                                 input_options, merged_input_options)
    end
  end

  def grouped_collection
    StateOptions.grouped_options
  end

  def group_method
    :last
  end
end
