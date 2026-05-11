class DateInput < SimpleForm::Inputs::DateTimeInput
  def input_html_options
    { 'data-form-type': 'other' }.deep_merge(super)
  end
end
