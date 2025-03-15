module RadNav
  class DropdownMenuUsersItem
    attr_accessor :view_context

    delegate :content, :badge, to: :nav

    def initialize(view_context)
      @view_context = view_context
    end

    def label
      'Users'
    end

    private

      def nav
        @nav ||= DropdownMenuIndexItem.new(view_context, 'User')
      end
  end
end
