module RadNav
  class TopNavItem
    attr_accessor :view_context, :label, :path, :badge, :icon_name

    delegate :tag, :link_to, :safe_join, :icon, to: :view_context

    def initialize(view_context, label, path, badge: nil, icon_name: nil)
      @view_context = view_context
      @label = label
      @path = path
      @badge = badge
      @icon_name = icon_name
    end

    def content
      data_attrs = {}
      if badge.present?
        data_attrs[:has_badge] = 'true'
        data_attrs[:bs_toggle] = 'tooltip'
        data_attrs[:bs_placement] = 'right'
      end

      tag.li(class: 'nav-item') do
        link_to path, class: 'nav-link', title: tooltip_text, data: data_attrs do
          safe_join([
            icon(icon_name || default_icon),
            tag.span(label, class: 'nav-text'),
            badge&.content
          ].compact, ' ')
        end
      end
    end

    private

      def default_icon
        'circle'
      end

      def tooltip_text
        return label if badge.blank?

        "#{label} (#{badge.count} notifications)"
      end
  end
end
