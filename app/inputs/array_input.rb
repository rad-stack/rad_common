# http://railsguides.net/simple-form-array-text-input/

class ArrayInput < SimpleForm::Inputs::StringInput
  def input(_wrapper_options)
    input_html_options[:type] ||= input_type
    array_elements = options[:collection].presence || object.public_send(attribute_name)
    array_elements = [] << '' if array_elements.blank?
    html = Array(array_elements).map { |array_el|
      @builder.text_field(nil, input_html_options.merge(value: array_el, name: "#{object_name}[#{attribute_name}][]"))
    }.join.html_safe

    html + "<button class=\"btn btn-primary btn-sm array-add-btn\" type=\"button\">Add #{ActiveRecord::Base.human_attribute_name(attribute_name).singularize.downcase}</button>".html_safe
  end

  def input_type
    :number
  end

  def input_html_classes
    super.push("array-field mb-2 form-control#{errors.any? ? ' is-invalid' : ''}")
  end
end
