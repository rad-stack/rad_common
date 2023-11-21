module RadNav
  class AdminMenu
    attr_accessor :view_context, :additional_items

    delegate :current_user, :render, :safe_join, to: :view_context

    def initialize(view_context, additional_items: [])
      @view_context = view_context
      @additional_items = additional_items
    end

    def content
      return unless current_user.admin?

      RadNav::DropdownMenu.new(view_context, 'Admin', admin_menu_items).content
    end

    private

      def admin_menu_items
        safe_join(additional_items + [render('layouts/navigation_admin', no_divider: no_admin_divider?)])
      end

      def no_admin_divider?
        additional_items.blank?
      end
  end
end
