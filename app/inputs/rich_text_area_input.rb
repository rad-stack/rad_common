class RichTextAreaInput < SimpleForm::Inputs::Base
  # TODO: using workaround in here: https://github.com/heartcombo/simple_form/issues/1638
  # https://swell.radicalbear.com/tasks/31625

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.rich_text_area(attribute_name, merged_input_options)
  end
end
