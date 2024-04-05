class ContactLogSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: ContactLogRecipient.joins(:contact_log),
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def filters_def
      [{ input_label: 'Log Type',
         name: :log_type,
         scope_values: ContactLog.log_types.keys.index_by { |record|
           RadEnum.new(ContactLog, :log_type).translation(record)
         }.transform_values(&:to_sym) },
       { start_input_label: 'Start Date',
         end_input_label: 'End Date',
         column: :created_at,
         type: RadCommon::DateFilter },
       { input_label: 'From Number',
         column: :from_number,
         type: RadCommon::PhoneNumberFilter,
         name: :from_number },
       { input_label: 'To Number',
         column: :to_number,
         type: RadCommon::PhoneNumberFilter,
         name: :to_number },
       { input_label: 'From User',
         column: :from_user_id,
         options: user_array,
         blank_value_label: 'All Users' },
       { input_label: 'To User',
         column: :to_user_id,
         options: user_array,
         blank_value_label: 'All Users' },
       { column: 'message', type: RadCommon::LikeFilter },
       { input_label: 'Status', name: :status, scope_values: %i[failure successful] }]
    end

    def sort_columns_def
      [{ column: 'log_type' },
       { label: 'When', column: 'created_at', direction: 'desc', default: true },
       { column: 'from_number' },
       { column: 'to_number' },
       { label: 'From User' },
       { label: 'To User' },
       { column: 'message' },
       { column: 'opt_out_message_sent' },
       { label: 'Status' }]
    end

    def user_array
      Pundit.policy_scope!(current_user, User).by_name.pluck(Arel.sql("first_name || ' ' || last_name"), :id)
    end
end
