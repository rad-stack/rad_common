class Nav < RadNav::Nav
  def content
    [top_nav_index_item('Client'),
     top_nav_item('Contact', view_context.contact_us_path),
     top_nav_index_item('Attorney'),
     user_nav,
     admin_menu(false, additional_items: [division_item])]
  end

  private

    def division_item
      dropdown_menu_index_item('Division', path: view_context.divisions_path(search: { show_header: 'true' }))
    end
end
