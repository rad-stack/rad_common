# http://railsguides.net/simple-form-array-text-input/

class ArrayInput < SimpleForm::Inputs::StringInput
  def input(_wrapper_options)
    input_html_options[:type] ||= input_type

    array_elements = object.public_send(attribute_name)
    array_elements = [] << '' if array_elements.blank?

    html_items = Array(array_elements).map do |array_el|
      @builder.text_field(nil, input_html_options.merge(value: array_el, name: "#{object_name}[#{attribute_name}][]"))
    end

    html_items.push(button_tag)

    safe_join html_items
  end

  def input_type
    :number
  end

  def input_html_classes
    super.push("array-field mb-2 form-control#{errors.any? ? ' is-invalid' : ''}")
  end

  private

    def button_tag
      tag.button "Add #{ActiveRecord::Base.human_attribute_name(attribute_name).singularize.downcase}",
                 class: 'btn btn-primary btn-sm array-add-btn', type: 'button'
    end
end
