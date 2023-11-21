module RadNav
  class DropdownMenu
    attr_accessor :view_context, :label, :items

    delegate :tag, :safe_join, to: :view_context

    def initialize(view_context, label, items)
      @view_context = view_context
      @label = label
      @items = items
    end

    def content
      tag.li(class: 'nav-item dropdown px-3') do # TODO: do we like the px-3?
        safe_join [menu_header(label), menu_content(items)]
      end
    end

    private

      def menu_header(label)
        tag.a(class: 'nav-link dropdown-toggle', 'data-toggle': 'dropdown', href: '#') do
          label
        end
      end

      def menu_content(items)
        tag.ul(class: 'dropdown-menu') do
          items
        end
      end
  end
end
