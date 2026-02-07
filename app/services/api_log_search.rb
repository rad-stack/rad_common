class ApiLogSearch < RadSearch::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: ApiLog,
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def filters_def
      [{ start_input_label: 'Start Date',
         end_input_label: 'End Date',
         column: :created_at,
         type: RadSearch::DateFilter },
       { input_label: 'Service Name',
         column: :service_name,
         options: service_name_options,
         blank_value_label: 'All' },
       { input_label: 'HTTP Method',
         column: :http_method,
         options: http_method_options,
         blank_value_label: 'All' },
       { column: :url, type: RadSearch::LikeFilter },
       { column: :success, input_label: 'Success?', type: RadSearch::BooleanFilter },
       { input_label: 'Response Status', column: :response_status, type: RadSearch::EqualsFilter, data_type: :integer }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
       { label: 'Service', column: 'service_name' },
       { label: 'Method', column: 'http_method' },
       { label: 'URL' },
       { label: 'Status', column: 'response_status' },
       { label: 'Duration (ms)', column: 'duration_ms' },
       { label: 'Success?' }]
    end

    def service_name_options
      ApiLog.group(:service_name).order(:service_name).pluck(:service_name)
    end

    def http_method_options
      ApiLog.group(:http_method).order(:http_method).pluck(:http_method)
    end
end
