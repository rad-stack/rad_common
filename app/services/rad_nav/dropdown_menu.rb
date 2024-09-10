module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items, :permission

    delegate :tag, :safe_join, to: :view_context

    def initialize(view_context, label, items, sort: false, permission: true)
      @view_context = view_context
      @label = label
      @items = sort ? items.compact.sort_by(&:label) : items.compact
      @permission = permission
    end

    def content
      return unless permission

      check_items
      return if content_items.empty?

      tag.li(class: 'nav-item dropdown px-2') do
        safe_join [menu_header, menu_content]
      end
    end

    private

      def menu_header
        tag.a(class: 'nav-link dropdown-toggle', 'data-toggle': 'dropdown', href: '#') do
          badge.present? ? safe_join([label, ' ', badge.content].compact) : label
        end
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
