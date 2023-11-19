class RadNav
  attr_accessor :view_context

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

    def top_nav_index_item(model_name, path: nil, badge: nil, label: nil)
      return unless policy(model_name.constantize).index?

      top_nav_item label.presence || model_name.titleize.pluralize,
                   path.presence || "/#{model_name.constantize.table_name}",
                   badge: badge
    end

    def top_nav_item(label, path, badge: nil)
      tag.li do
        link_to path, class: 'nav-link px-3' do # TODO: do we like the px-3?
          badge.present? ? safe_join([label, ' ', badge].compact) : label
        end
      end
    end

    def admin_menu
      return unless current_user.admin?

      tag.li(class: 'nav-item dropdown px-3') do # TODO: do we like the px-3?
        safe_join [dropdown_menu('Admin'), admin_nav]
      end
    end

    def user_nav
      top_nav_index_item('User')
    end

    def dropdown_menu(label)
      tag.a(class: 'nav-link dropdown-toggle', 'data-toggle': 'dropdown', href: '#') do
        label
      end
    end

    def dropdown_menu_item(label, path)
      tag.li do
        link_to label, path, class: 'dropdown-item'
      end
    end

    def additional_admin_items
      []
    end

    def admin_nav
      tag.ul(class: 'dropdown-menu') do
        safe_join(additional_admin_items + [render('layouts/navigation_admin', no_divider: no_admin_divider?)])
      end
    end

    def no_admin_divider?
      additional_admin_items.blank?
    end
end
