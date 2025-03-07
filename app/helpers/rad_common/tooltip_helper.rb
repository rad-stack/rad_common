module RadCommon
  module TooltipHelper
    def icon_tooltip(html_tag, title, icon = 'fa-circle-question', html_class: '')
      return if title.blank?

      tag(html_tag.to_s,
          class: "fa #{icon} tooltip-pad custom-tooltip #{html_class}",
          data: { toggle: 'tooltip', placement: 'top' },
          title: title.to_s)
    end

    def tooltip(html_tag, title)
      return if title.blank?

      tag(html_tag.to_s,
          class: 'custom-tooltip',
          data: { toggle: 'tooltip', placement: 'top' },
          title: title.to_s)
    end
  end
end
