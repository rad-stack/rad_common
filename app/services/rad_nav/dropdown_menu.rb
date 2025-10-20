module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items, :permission, :icon_name

    delegate :tag, :safe_join, :icon, to: :view_context

    def initialize(view_context, label, items, sort: false, permission: true, icon_name: nil)
      @view_context = view_context
      @label = label
      @items = sort ? items.compact.sort_by(&:label) : items.compact
      @permission = permission
      @icon_name = icon_name
    end

    def content
      return unless permission

      check_items
      return if content_items.empty?

      tag.li(class: 'nav-item dropdown') do
        safe_join [menu_header, menu_content]
      end
    end

    private

      def menu_header
        data_attrs = { bs_toggle: 'dropdown' }
        data_attrs[:has_badge] = 'true' if badge.present?

        tag.a(
          class: 'nav-link dropdown-toggle',
          href: '#',
          data: data_attrs
        ) do
          safe_join([
            icon(icon_name || default_icon),
            tag.span(label, class: 'nav-text'),
            badge&.content
          ].compact, ' ')
        end
      end

      def tooltip_text
        return label if badge.blank?

        "#{label} (#{badge_count} notifications)"
      end

      def default_icon
        'folder'
      end

      def badge
        return if badges.empty? || badge_count.zero?

        NavBadge.new(view_context, badge_style, badge_count)
      end

      def badge_count
        @badge_count ||= badges.map(&:count).sum
      end

      def badge_style
        NavBadge.highest_alert_style badges
      end

      def badges
        @badges ||= items.select { |item| item.respond_to?(:badge) && item.badge.present? }.map(&:badge)
      end

      def menu_content
        tag.ul(class: 'dropdown-menu') do
          safe_join(content_items)
        end
      end

      def content_items
        @content_items ||= items.map(&:content).compact
      end

      def check_items
        raise 'missing items' if items.empty?

        items.each do |item|
          next if item.is_a?(DropdownMenuItem) ||
                  item.is_a?(DropdownMenuIndexItem) ||
                  item.is_a?(NavDivider) ||
                  item.is_a?(DropdownMenuUsersItem)

          raise "invalid item: #{item.class}"
        end
      end
  end
end
