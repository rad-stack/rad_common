module RadNav
  class Nav
    attr_accessor :view_context, :disable_nav

    delegate :policy, :policy_scope, :current_user, to: :view_context
    delegate :admin?, to: :current_user

    def initialize(view_context, disable_nav: false)
      @view_context = view_context
      @disable_nav = disable_nav
    end

    def content
      check_items

      nav_items.compact.map(&:content)
    end

    def disable_nav?
      disable_nav
    end

    private

      def top_nav_items
        raise 'implement in subclasses'
      end

      def nav_items
        @nav_items ||= top_nav_items
      end

      def top_nav_index_item(model_name, path: nil, label: nil)
        TopNavIndexItem.new(view_context, model_name, path: path, label: label)
      end

      def top_nav_item(label, path, badge: nil)
        TopNavItem.new(view_context, label, path, badge: badge)
      end

      def dropdown_menu_index_item(model_name, path: nil, label: nil, badge: nil)
        DropdownMenuIndexItem.new(view_context, model_name, path: path, label: label, badge: badge)
      end

      def dropdown_menu(label, items, sort: false, permission: true)
        DropdownMenu.new(view_context, label, items, sort: sort, permission: permission)
      end

      def dropdown_menu_item(label, path, badge: nil, link_options: {}, permission: true)
        DropdownMenuItem.new(view_context,
                             label, path,
                             badge: badge,
                             link_options: link_options,
                             permission: permission)
      end

      def nav_badge(alert_style, count)
        NavBadge.new(view_context, alert_style, count)
      end

      def top_nav_users
        TopNavUsers.new(view_context)
      end

      def admin_menu(include_users, additional_items: [])
        AdminMenu.new(view_context, include_users, additional_items: additional_items)
      end

      def check_items
        raise 'missing items' if nav_items.nil? || nav_items.compact.empty?

        check_item_types
      end

      def check_item_types
        nav_items.compact.each do |item|
          next if item.is_a?(TopNavItem) ||
                  item.is_a?(TopNavIndexItem) ||
                  item.is_a?(DropdownMenu) ||
                  item.is_a?(TopNavUsers) ||
                  item.is_a?(AdminMenu)

          raise "invalid item: #{item.class}"
        end
      end
  end
end
