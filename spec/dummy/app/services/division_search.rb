class DivisionSearch
  def self.search(query, params, current_user)
    filters = [{ input_label: 'Owner', column: :owner_id, options: User.by_name }]

    # TODO: sorts should be optional, remove from here when fixed
    sorts = [{ column: 'name', label: 'Name', direction: 'desc' }]

    RadCommon::Search.new(query: query,
                          filters: filters,
                          sort_columns: sorts,
                          current_user: current_user,
                          params: params)
  end
end
