class Nav < RadNav::Nav
  def top_nav
    [RadNav::TopNavIndexItem.new(view_context, 'Client').content,
     RadNav::TopNavItem.new(view_context, 'Contact', view_context.contact_us_path).content,
     RadNav::TopNavIndexItem.new(view_context, 'Attorney', badge: duplicates_badge(Attorney)).content,
     RadNav::UserNav.new(view_context).content,
     admin_menu]
  end

  private

    def additional_admin_items
      [division_item]
    end

    def division_item
      RadNav::DropdownMenuItem.new(view_context,
                                   'Divisions',
                                   view_context.divisions_path(search: { show_header: 'true' })).content
    end
end
