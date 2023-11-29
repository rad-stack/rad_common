module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items, :permission

    delegate :tag, :safe_join, to: :view_context

    def initialize(view_context, label, items, permission: true)
      @view_context = view_context
      @label = label
      @items = items.compact
      @permission = permission
    end

    def content
      check_items
      return unless permission

      tag.li(class: 'nav-item dropdown px-3') do # TODO: do we like the px-3?
        safe_join [menu_header(label), menu_content(items)]
      end
    end

    private

      def menu_header(label)
        tag.a(class: 'nav-link dropdown-toggle', 'data-toggle': 'dropdown', href: '#') do
          badge.present? ? safe_join([label, ' ', badge.content].compact) : label
        end
      end

      def badge
        return if badges.empty? || badge_count.zero?

        RadNav::NavBadge.new(view_context, badge_style, badge_count)
      end

      def badge_count
        @badge_count ||= badges.map(&:count).sum
      end

      def badge_style
        styles = badges.map(&:alert_style).uniq
        return styles.first if styles.count == 1

        raise 'conflicting badge styles'
      end

      def badges
        @badges ||= items.select { |item| item.respond_to?(:badge) && item.badge.present? }.map(&:badge)
      end

      def menu_content(items)
        tag.ul(class: 'dropdown-menu') do
          safe_join(items.map(&:content))
        end
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
