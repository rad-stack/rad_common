class LoginActivitySearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: LoginActivity,
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
         type: RadCommon::DateFilter },
       { column: 'identity',
         type: RadCommon::LikeFilter },
       { input_label: 'Login Status',
         name: :status,
         scope_values: { Failure: :failure, Success: :successful },
         blank_value_label: 'All' },
       { input_label: 'Failure Reason',
         column: :failure_reason,
         options: failure_reasons,
         blank_value_label: 'All' },
       { column: :ip, type: RadCommon::LikeFilter },
       { column: :user_agent,
         type: RadCommon::LikeFilter },
       { column: :referrer,
         type: RadCommon::LikeFilter }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
       { label: 'Identity', column: 'identity' },
       { label: 'Success' },
       { label: 'Failure' },
       { label: 'IP', column: 'ip' },
       { label: 'Agent', column: 'user_agent' },
       { column: 'referrer' }]
    end

    def failure_reasons
      Pundit.policy_scope!(current_user, LoginActivity).failure.select(:failure_reason).distinct.map(&:failure_reason)
    end
end
