module SimpleForm
  module Components
    module Tooltips
      def icon(wrapper_options = nil)
        return tooltip_tag if options[:tooltip].present?
        return icon_tag    if options[:icon].present?
      end

      def icon_tag
        template.content_tag(:i, '', class: "fa #{options[:icon]} tooltip-pad")
      end

      def tooltip_tag
        template.content_tag(:i, '', class: "fa fa-question-circle custom-tooltip tooltip-pad", 'data-toggle' => 'tooltip', 'data-original-title' => options[:tooltip])
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Tooltips)
