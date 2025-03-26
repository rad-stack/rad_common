class ContactLogSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: ContactLog,
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
       { input_label: 'Incoming/Outgoing',
         name: :dir,
         scope_values: { Incoming: :incoming, Outgoing: :outgoing },
         blank_value_label: 'All' },
       { input_label: 'From User',
         column: :from_user_id,
         options: user_array,
         blank_value_label: 'All Users' },
       { input_label: 'To User',
         column: :to_user_id,
         options: user_array,
         blank_value_label: 'All Users' }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
       { column: 'from_number' },
       { column: 'to_number' },
       { label: 'From User' },
       { label: 'To User' },
       { column: 'message' },
       { column: 'media_url' },
       { column: 'opt_out_message_sent' },
       { column: 'success' }]
    end

    def user_array
      Pundit.policy_scope!(current_user, User).by_name.pluck(Arel.sql("first_name || ' ' || last_name"), :id)
    end

    def failure_reasons
      Pundit.policy_scope!(current_user, LoginActivity).failure.select(:failure_reason).distinct.map(&:failure_reason)
    end
end
