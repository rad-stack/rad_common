class DivisionSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: Division.sorted,
          filters: filters_def,
          current_user: current_user,
          search_name: 'divisions_search',
          sticky_filters: true,
          params: params)
  end

  def filters_def
    [{ input_label: 'Owner',
       column: :owner_id,
       default_value: current_user.id,
       options: [['Active', User.active.by_name],
                 ['Inactive', User.inactive.by_name]],
       grouped: true },
     { input_label: 'Status', column: :division_status,
       options: RadicalEnum.new(Division, :division_status).db_options,
       required: true },
     { column: :name, type: RadCommon::LikeFilter },
     { column: :created_at, type: RadCommon::DateFilter,
       start_input_label: 'Division Created At Start',
       end_input_label: 'Division Created At End',
       default_start_value: Date.current, default_end_value: Date.current },
     { name: 'show_header', type: RadCommon::HiddenFilter }]
  end

  def show_header?
    selected_value('show_header') == 'true'
  end
end
