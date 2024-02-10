module RadTable
  class SecuredLinkColumn < Column
    def format_value(value)
      view_context.secured_link(value)
    end
  end
end
