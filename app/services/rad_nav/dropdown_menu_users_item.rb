module RadNav
  class DropdownMenuUsersItem
    attr_accessor :view_context

    def initialize(view_context)
      @view_context = view_context
    end

    def content
      nav.content
    end

    def badge
      nav.badge
    end

    private

      def nav
        @nav ||= RadNav::DropdownMenuIndexItem.new(view_context, 'User')
      end
  end
end
