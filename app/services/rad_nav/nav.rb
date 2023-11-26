module RadNav
  class Nav
    attr_accessor :view_context, :disable_nav

    delegate :policy, :current_user, to: :view_context
    delegate :admin?, to: :current_user

    def initialize(view_context, disable_nav: false)
      @view_context = view_context
      @disable_nav = disable_nav
    end

    def top_nav_index_item(model_name, path: nil, label: nil)
      RadNav::TopNavIndexItem.new(view_context, model_name, path: path, label: label).content
    end

    def top_nav_item(label, path, badge: nil)
      RadNav::TopNavItem.new(view_context, label, path, badge: badge).content
    end

    def dropdown_menu_index_item(model_name, path: nil, label: nil)
      RadNav::DropdownMenuIndexItem.new(view_context, model_name, path: path, label: label).content
    end

    def user_nav
      RadNav::UserNav.new(view_context).content
    end

    def admin_menu(include_users, additional_items: [])
      RadNav::AdminMenu.new(view_context, include_users, additional_items: additional_items).content
    end

    def content
      raise 'implement in subclasses'
    end

    def disable_nav?
      disable_nav
    end
  end
end
