class Nav < RadNav::Nav
  def content
    [RadNav::TopNavIndexItem.new(view_context, 'Client').content,
     RadNav::TopNavItem.new(view_context, 'Contact', view_context.contact_us_path).content,
     attorney_item,
     RadNav::UserNav.new(view_context).content,
     RadNav::AdminMenu.new(view_context, false, additional_items: [division_item]).content]
  end

  private

    def attorney_item
      RadNav::TopNavIndexItem.new(view_context, 'Attorney').content
    end

    def division_item
      RadNav::DropdownMenuIndexItem.new(view_context,
                                        'Division',
                                        path: view_context.divisions_path(search: { show_header: 'true' })).content
    end
end
