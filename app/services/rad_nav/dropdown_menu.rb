module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items, :permission

    delegate :tag, :safe_join, to: :view_context

    def initialize(view_context, label, items, permission: true)
      @view_context = view_context
      @label = label
      @items = items.compact
      @permission = permission

      check_items
    end

    def content
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
        @badge_count ||= badges.map { |item| item.count }.sum
      end

      def badge_style
        styles = badges.map { |item| item.alert_style }.uniq
        return styles.first if styles.count == 1

        raise 'conflicting badge styles'
      end

      def badges
        @badges ||= items.select { |item| item.respond_to?(:badge) && item.badge.present? }.map { |item| item.badge }
      end

      def menu_content(items)
        tag.ul(class: 'dropdown-menu') do
          safe_join items.map { |item| item.content }
        end
      end

      def check_items
        # raise if empty
        # TODO: fix
        # items.each do |item|
        #   raise "invalid item: #{item}" unless item.include?('dropdown-item') || item.to_s.include?('dropdown-divider')
        # end
      end
  end
end
