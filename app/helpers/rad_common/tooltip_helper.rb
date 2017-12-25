module RadCommon
  module TooltipHelper
    def icon_tooltip(html_tag, title, placement = 'top')
      return if title.blank?
      tag("#{html_tag}", class: 'fa fa-question-circle tooltip-pad custom-tooltip', data: { toggle: 'tooltip', placement: "#{placement}" }, title: "#{title}")
    end

    def tooltip(html_tag, title, placement = 'top')
      return if title.blank?
      tag("#{html_tag}", class: 'custom-tooltip', data: { toggle: 'tooltip', placement: "#{placement}" }, title: "#{title}")
    end
  end
end
