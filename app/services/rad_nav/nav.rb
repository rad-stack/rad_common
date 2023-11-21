module RadNav
  class Nav
    attr_accessor :view_context

    def initialize(view_context)
      @view_context = view_context
    end

    def top_nav
      raise 'implement in subclasses'
    end

    def disable_nav?
      false
    end
  end
end
