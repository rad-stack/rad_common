class TwilioLogSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: TwilioLog,
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
         type: RadCommon::DateFilter }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
       { column: 'from_number' },
       { column: 'to_number' },
       { label: 'User' },
       { column: 'message' },
       { column: 'media_url' },
       { column: 'success' }]
    end

    def failure_reasons
      Pundit.policy_scope!(current_user, LoginActivity).failure.select(:failure_reason).distinct.map(&:failure_reason)
    end
end
