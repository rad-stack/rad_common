class Nav < RadNav::Nav
  private

    def top_nav_items
      [dropdown_menu('Clients', client_items, icon_name: 'briefcase'),
       attorneys_menu,
       top_nav_item('Contact', view_context.new_company_contact_path, badge: nav_badge(:danger, 9), icon_name: 'envelope'),
       top_nav_users,
       dropdown_menu('Divisions', division_items, icon_name: 'building'),
       admin_menu(false)]
    end

    def client_items
      [dropdown_menu_index_item('Client'),
       dropdown_menu_item('Add Client', view_context.new_client_path, permission: policy(Client.new).new?),
       dropdown_menu_item('Client Report', view_context.client_reports_path, permission: policy(Client.new).report?)]
    end

    def attorneys_menu
      if policy(Attorney.new).new?
        dropdown_menu('Attorneys', attorney_items, icon_name: 'scale-balanced')
      else
        top_nav_index_item('Attorney')
      end
    end

    def attorney_items
      [dropdown_menu_index_item('Attorney'),
       dropdown_menu_item('Add Attorney', view_context.new_attorney_path)]
    end

    def division_items
      [dropdown_menu_index_item('Division', path: view_context.divisions_path(search: { show_header: 'true' })),
       dropdown_menu_index_item('Division', path: view_context.calendar_divisions_path, label: 'Calendar')]
    end
end
