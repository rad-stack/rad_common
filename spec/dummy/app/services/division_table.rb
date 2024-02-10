class DivisionTable < RadTable::Table
  def columns
    [
      RadTable::SecuredLinkColumn.new(:name, value_parser: ->(record) { record }),
      RadTable::Column.new(:code),
      RadTable::SecuredLinkColumn.new(:owner),
      RadTable::AttachmentColumn.new(:logo),
      RadTable::ActionsColumn.new(:actions, hidden: !view_context.show_actions?(Division))
    ]
  end

  def path(search_params = nil)
    return view_context.divisions_path(search: search_params) if search_params.present?

    view_context.divisions_path
  end
end
