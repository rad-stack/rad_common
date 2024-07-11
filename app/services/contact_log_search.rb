class ContactLogSearch < RadCommon::Search
  def initialize(params, current_user, related_to_type: nil, related_to_id: nil)
    @current_user = current_user
    @related_to = related_to_type.constantize.find(related_to_id) if related_to_type.present?

    super(query: query_def,
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def query_def
      return ContactLog.related_to(@related_to).includes(:contact_log_recipients) if @related_to.present?

      ContactLog.includes(:contact_log_recipients)
    end

    def filters_def
      [{ start_input_label: 'Start Date',
         end_input_label: 'End Date',
         column: :created_at,
         type: RadCommon::DateFilter },
       { input_label: 'Service Type', name: :service_type, scope_values: enum_scopes(ContactLog, :service_type) },
       { input_label: 'Log Type', name: :log_type, scope_values: enum_scopes(ContactLog, :sms_log_type) },
       { input_label: 'From Number',
         column: 'contact_logs.from_number',
         type: RadCommon::PhoneNumberFilter,
         name: :from_number },
       { input_label: 'From Email', column: 'contact_logs.from_email', type: RadCommon::LikeFilter, name: :from_email },
       { input_label: 'From User',
         column: 'contact_logs.from_user_id',
         options: user_array,
         blank_value_label: 'All Users' },
       { input_label: 'Record Type', column: 'contact_logs.record_type', options: record_type_options },
       { input_label: 'Record ID', column: :record_id, type: RadCommon::EqualsFilter, data_type: :integer },
       { input_label: 'Content', column: 'content', type: RadCommon::LikeFilter }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
       { label: 'Service Type', column: 'contact_logs.service_type' },
       { label: 'Log Type', column: 'contact_logs.sms_log_type' },
       { label: 'From' },
       { label: 'To' },
       { label: 'Record' },
       { label: 'Content', column: 'contact_logs.content' },
       { label: 'Opt Out Message Sent?', column: 'contact_logs.sms_opt_out_message_sent' },
       { label: 'Success' }]
    end

    def user_array
      Pundit.policy_scope!(current_user, User).sorted.pluck(Arel.sql("first_name || ' ' || last_name"), :id)
    end

    def record_type_options
      ContactLog.group(:record_type).select(:record_type).order(:record_type).pluck(:record_type)
    end
end
