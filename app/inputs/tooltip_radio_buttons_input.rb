class TooltipRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.send(:collection_radio_buttons,
                  attribute_name, collection, value_method, label_method,
                  input_options, merged_input_options) do |button|
      render_button(button)
    end
  end

  def render_button(button)
    children = [button.radio_button, button.label, tooltip(button)].compact
    button.label(class: item_wrapper_class) do
      safe_join(children)
    end
  end

  def tooltips
    @tooltips ||= input_options[:tooltips]
  end

  def tooltip_value(value)
    tooltips[value.to_sym]
  end

  def tooltip(button)
    template.content_tag(:i, '', class: 'fa fa-circle-question custom-tooltip tooltip-pad ms-1',
                                 'data-bs-toggle' => 'tooltip',
                                 'data-bs-title' => tooltip_value(button.value))
  end
end
