class Nav < RadNav::Nav
  def content
    [RadNav::TopNavIndexItem.new(view_context, 'Client').content,
     RadNav::TopNavItem.new(view_context, 'Contact', view_context.contact_us_path).content,
     attorney_item,
     RadNav::UserNav.new(view_context).content,
     RadNav::AdminMenu.new(view_context, additional_items: [division_item]).content]
  end

  private

    def attorney_item
      RadNav::TopNavIndexItem.new(view_context,
                                  'Attorney',
                                  badge: view_context.duplicates_badge(Attorney)).content
    end

    def division_item
      RadNav::DropdownMenuItem.new(view_context,
                                   'Divisions',
                                   view_context.divisions_path(search: { show_header: 'true' })).content
    end
end
