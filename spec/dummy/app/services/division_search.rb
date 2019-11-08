class DivisionSearch
  def self.search(query, params, current_user)
    filters = [{ input_label: 'Owner', column: :owner_id, options: User.by_name }]
    RadCommon::Search.new(query: query, filters: filters, current_user: current_user, params: params)
  end
end
