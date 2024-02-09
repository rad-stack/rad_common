class DivisionTable < RadTable
  def columns
    [
      { name: :name },
      { name: :code },
      { name: :owner, type: :secured_link },
      { name: :logo, type: :attachment },
      actions_column
    ]
  end

  def show_actions?
    view_context.show_actions?(Division)
  end

  def path(search_params = nil)
    return view_context.divisions_path(search: search_params) if search_params.present?

    view_context.divisions_path
  end
end
