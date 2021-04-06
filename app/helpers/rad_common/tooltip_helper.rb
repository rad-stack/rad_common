module RadCommon
  module TooltipHelper
    def icon_tooltip(html_tag, title, placement = 'top', icon = 'fa-question-circle')
      return if title.blank?

      tag(html_tag.to_s,
          class: "fa #{icon} tooltip-pad custom-tooltip",
          data: { toggle: 'tooltip', placement: placement.to_s },
          title: title.to_s)
    end

    def tooltip(html_tag, title, placement = 'top')
      return if title.blank?

      tag(html_tag.to_s,
          class: 'custom-tooltip',
          data: { toggle: 'tooltip', placement: placement.to_s },
          title: title.to_s)
    end
  end
end
