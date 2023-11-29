class Nav < RadNav::Nav
  def items
    [dropdown_menu('Clients', client_items),
     attorneys_menu,
     top_nav_item('Contact', view_context.contact_us_path, badge: nav_badge(:danger, 9)),
     top_nav_users,
     admin_menu(false, additional_items: [division_item])]
  end

  private

    def client_items
      [dropdown_menu_index_item('Client'),
       dropdown_menu_item('Add Client', view_context.new_client_path)]
    end

    def attorneys_menu
      if policy(Attorney.new).new?
        dropdown_menu('Attorneys', attorney_items)
      else
        top_nav_index_item('Attorney')
      end
    end

    def attorney_items
      [dropdown_menu_index_item('Attorney'),
       dropdown_menu_item('Add Attorney', view_context.new_attorney_path)]
    end

    def division_item
      dropdown_menu_index_item('Division', path: view_context.divisions_path(search: { show_header: 'true' }))
    end
end
