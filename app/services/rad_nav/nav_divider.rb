module RadNav
  class NavDivider
    attr_accessor :view_context

    delegate :tag, to: :view_context

    def initialize(view_context)
      @view_context = view_context
    end

    def content
      tag.li class: 'dropdown-divider'
    end
  end
end
