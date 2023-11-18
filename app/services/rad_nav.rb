class RadNav
  attr_accessor :view_context

  delegate :policy, :tag, :link_to, :safe_join, :duplicates_badge, :current_user, :render, to: :view_context

  def initialize(view_context)
    @view_context = view_context
  end

  def top_nav
    [top_nav_index_item('Client'),
     top_nav_item('Contact', view_context.contact_us_path),
     top_nav_index_item('Attorney', badge: duplicates_badge(Attorney)),
     top_nav_index_item('User'),
     admin_menu]
  end

  private

    def top_nav_index_item(model_name, path: nil, badge: nil)
      return unless policy(model_name.constantize).index?

      top_nav_item model_name.pluralize, path.presence || "/#{model_name.constantize.table_name}", badge: badge
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

    def dropdown_menu(label)
      tag.a(class: 'nav-link dropdown-toggle', 'data-toggle': 'dropdown', href: '#') do
        label
      end
    end

    def division_item
      tag.li do
        link_to 'Divisions', view_context.divisions_path(search: { show_header: 'true' }), class: 'dropdown-item'
      end
    end

    def admin_nav
      tag.ul(class: 'dropdown-menu') do
        safe_join([division_item, render('layouts/navigation_admin')])
      end
    end
end
