module RadNav
  class TopNavUsers
    attr_accessor :view_context

    def initialize(view_context)
      @view_context = view_context
    end

    def content
      TopNavIndexItem.new(view_context, 'User').content
    end
  end
end
