class DivisionSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: Division.sorted,
          filters: search_filters,
          current_user: current_user,
          search_name: 'divisions_search',
          sticky_filters: true,
          params: params)
  end

  def search_filters
    [{ input_label: 'Owner',
       column: :owner_id,
       default_value: current_user.id,
       options: [['Active', User.active.by_name],
                 ['Inactive', User.inactive.by_name]],
       grouped: true },
     { input_label: 'Status', column: :division_status,
       options: ApplicationController.helpers.db_options_for_enum(Division, :division_status) },
     { column: :name, type: RadCommon::LikeFilter },
     { column: :created_at, type: RadCommon::DateFilter,
       start_input_label: 'Division Created At Start',
       end_input_label: 'Division Created At End',
       default_start_value: Date.current, default_end_value: Date.current },
     { name: 'show_header', type: RadCommon::HiddenFilter } ]
  end
end
