class DatetimeLocalInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    input_html_options[:type] = 'text'
    input_html_options[:html5] = false
    input_html_options[:value] = value(object) ? value(object).strftime('%FT%R') : nil

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.text_field(attribute_name, merged_input_options)
  end

  def value(object)
    object&.send @attribute_name
  end
end
