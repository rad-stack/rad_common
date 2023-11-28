module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items, :badge, :permission

    delegate :tag, :safe_join, to: :view_context

    # TODO: try removing badge and derive it from items

    def initialize(view_context, label, items, badge: nil, permission: true)
      raise 'missing items' if items.empty?

      @view_context = view_context
      @label = label
      @items = items.compact.map { |item| item.content }
      @permission = permission
      @badge = badge

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

      def menu_content(items)
        tag.ul(class: 'dropdown-menu') do
          safe_join items
        end
      end

      def check_items
        # TODO: fix
        # items.each do |item|
        #   raise "invalid item: #{item}" unless item.include?('dropdown-item') || item.to_s.include?('dropdown-divider')
        # end
      end
  end
end
