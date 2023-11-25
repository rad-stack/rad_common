module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items, :badge, :permission

    delegate :tag, :safe_join, to: :view_context

    def initialize(view_context, label, items, badge: nil, permission: true)
      @view_context = view_context
      @label = label
      @items = items
      @permission = permission
      @badge = badge
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
          badge.present? ? safe_join([label, ' ', badge].compact) : label
        end
      end

      def menu_content(items)
        tag.ul(class: 'dropdown-menu') do
          safe_join items
        end
      end
  end
end
