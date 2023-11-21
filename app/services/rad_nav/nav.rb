module RadNav
  class Nav
    attr_accessor :view_context, :disable_nav

    def initialize(view_context, disable_nav: false)
      @view_context = view_context
      @disable_nav = disable_nav
    end

    def content
      raise 'implement in subclasses'
    end

    def disable_nav?
      disable_nav
    end
  end
end
