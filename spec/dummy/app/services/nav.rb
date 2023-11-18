class Nav < RadNav
  def top_nav
    [top_nav_index_item('Client'),
     top_nav_item('Contact', view_context.contact_us_path),
     top_nav_index_item('Attorney', badge: duplicates_badge(Attorney)),
     user_nav,
     admin_menu]
  end

  private

    def additional_admin_items
      [division_item]
    end

    def division_item
      dropdown_menu_item 'Divisions', view_context.divisions_path(search: { show_header: 'true' })
    end
end
