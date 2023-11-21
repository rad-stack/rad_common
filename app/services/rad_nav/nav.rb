module RadNav
  class Nav
    attr_accessor :view_context

    # TODO: remove unused
    delegate :safe_join, :duplicates_badge, :current_user, :render, to: :view_context

    def initialize(view_context)
      @view_context = view_context
    end

    def top_nav
      raise 'implement in subclasses'
    end

    def disable_nav?
      false
    end

    private

      def user_nav
        RadNav::TopNavIndexItem.new(view_context, 'User').content
      end

      def admin_menu
        return unless current_user.admin?

        RadNav::DropdownMenu.new(view_context, 'Admin', admin_menu_items).content
      end

      def admin_menu_items
        safe_join(additional_admin_items + [render('layouts/navigation_admin', no_divider: no_admin_divider?)])
      end

      def additional_admin_items
        []
      end

      def no_admin_divider?
        additional_admin_items.blank?
      end
  end
end
