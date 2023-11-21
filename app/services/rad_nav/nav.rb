module RadNav
  class Nav
    attr_accessor :view_context

    # TODO: remove unused
    delegate :policy, :tag, :link_to, :safe_join, :duplicates_badge, :current_user, :render, to: :view_context

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
        top_nav_index_item('User')
      end

      def admin_menu
        return unless current_user.admin?

        dropdown_menu 'Admin', admin_menu_items
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

      def dropdown_menu(label, items)
        tag.li(class: 'nav-item dropdown px-3') do # TODO: do we like the px-3?
          safe_join [dropdown_menu_header(label), dropdown_menu_content(items)]
        end
      end

      def dropdown_menu_header(label)
        tag.a(class: 'nav-link dropdown-toggle', 'data-toggle': 'dropdown', href: '#') do
          label
        end
      end

      def dropdown_menu_content(items)
        tag.ul(class: 'dropdown-menu') do
          items
        end
      end

      def dropdown_menu_item(label, path)
        tag.li do
          link_to label, path, class: 'dropdown-item'
        end
      end

      def top_nav_index_item(model_name, path: nil, badge: nil, label: nil)
        return unless policy(model_name.constantize).index?

        RadNav::TopNavItem.new(view_context,
                               label.presence || model_name.titleize.pluralize,
                               path.presence || "/#{model_name.constantize.table_name}",
                               badge: badge).content
      end
  end
end
