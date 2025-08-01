module SimpleForm
  module Components
    module Tooltips
      def icon(_wrapper_options = nil)
        return tooltip_tag if options[:tooltip].present?
        return if options[:icon].blank?

        icon_tag
      end

      def icon_tag
        template.content_tag(:i, '', class: "fa #{options[:icon]} tooltip-pad")
      end

      def tooltip_tag
        template.content_tag(:i, '', class: 'fa fa-circle-question custom-tooltip tooltip-pad',
                                     'data-bs-toggle' => 'tooltip',
                                     'data-bs-title' => options[:tooltip])
      end
    end
  end
end

SimpleForm::Inputs::Base.include SimpleForm::Components::Tooltips
