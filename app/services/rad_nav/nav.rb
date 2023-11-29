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

      items.map { |item| item.content }
    end

    def disable_nav?
      disable_nav
    end

    private

      def items
        raise 'implement in subclasses'
      end

      def top_nav_index_item(model_name, path: nil, label: nil)
        RadNav::TopNavIndexItem.new(view_context, model_name, path: path, label: label)
      end

      def top_nav_item(label, path, badge: nil)
        RadNav::TopNavItem.new(view_context, label, path, badge: badge)
      end

      def dropdown_menu_index_item(model_name, path: nil, label: nil, badge: nil)
        RadNav::DropdownMenuIndexItem.new(view_context, model_name, path: path, label: label, badge: badge)
      end

      def dropdown_menu(label, items, permission: true)
        RadNav::DropdownMenu.new(view_context, label, items, permission: permission)
      end

      def dropdown_menu_item(label, path, badge: nil, link_options: {}, permission: true)
        RadNav::DropdownMenuItem.new(view_context,
                                     label, path,
                                     badge: badge,
                                     link_options: link_options,
                                     permission: permission)
      end

      def nav_badge(alert_style, count)
        RadNav::NavBadge.new(view_context, alert_style, count)
      end

      def top_nav_users
        RadNav::TopNavUsers.new(view_context)
      end

      def admin_menu(include_users, additional_items: [])
        RadNav::AdminMenu.new(view_context, include_users, additional_items: additional_items)
      end

      def check_items
        raise 'missing items' if items.compact.empty?

        items.compact.each do |item|
          next if item.is_a?(RadNav::TopNavItem) ||
                  item.is_a?(RadNav::TopNavIndexItem) ||
                  item.is_a?(RadNav::DropdownMenu) ||
                  item.is_a?(RadNav::TopNavUsers) ||
                  item.is_a?(RadNav::AdminMenu)

          raise "invalid item: #{item.class}"
        end
      end
  end
end
