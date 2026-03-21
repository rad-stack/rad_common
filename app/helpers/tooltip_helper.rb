module TooltipHelper
  def icon_tooltip(html_tag, title, icon = 'fa-circle-question', html_class: '', placement: 'top')
    return if title.blank?

    tag(html_tag.to_s,
        class: "fa #{icon} tooltip-pad custom-tooltip #{html_class}",
        'data-bs-toggle': 'tooltip', 'data-bs-placement': placement,
        title: title.to_s)
  end

  def tooltip(html_tag, title)
    return if title.blank?

    tag(html_tag.to_s,
        class: 'custom-tooltip',
        'data-bs-toggle': 'tooltip', 'data-bs-placement': 'top',
        title: title.to_s)
  end
end
