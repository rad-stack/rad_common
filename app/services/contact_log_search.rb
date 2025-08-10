class ContactLogSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: ContactLog.left_joins(:contact_log_recipients).includes(:contact_log_recipients).distinct,
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def filters_def
      [date_filter,
       { column: :service_type, type: RadCommon::EnumFilter, klass: ContactLog },
       { input_label: 'Log Type', column: :sms_log_type, type: RadCommon::EnumFilter, klass: ContactLog },
       user_filter('From User', 'contact_logs.from_user_id'),
       { input_label: 'From Number',
         column: 'contact_logs.from_number',
         type: RadCommon::PhoneNumberFilter,
         name: :from_number },
       { input_label: 'From Email', column: 'contact_logs.from_email', type: RadCommon::LikeFilter, name: :from_email },
       user_filter('To User', 'contact_log_recipients.to_user_id'),
       { input_label: 'To Number',
         column: 'contact_log_recipients.phone_number',
         type: RadCommon::PhoneNumberFilter,
         name: :to_number },
       { input_label: 'To Email',
         column: 'contact_log_recipients.email',
         type: RadCommon::LikeFilter,
         name: :to_email },
       { input_label: 'Record Type', column: 'contact_logs.record_type', options: record_type_options },
       { input_label: 'Record ID', column: :record_id, type: RadCommon::EqualsFilter, data_type: :integer },
       user_filter('Associated User', 'associated_with_user', :associated_with_user),
       { input_label: 'Content', column: 'content', type: RadCommon::LikeFilter },
       { input_label: 'SMS Message ID', column: 'sms_message_id', type: RadCommon::LikeFilter },
       { column: 'contact_log_recipients.success', input_label: 'Success?', type: RadCommon::BooleanFilter }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'contact_logs.created_at', direction: 'desc', default: true },
       { label: 'Service Type', column: 'contact_logs.service_type' },
       { label: 'Log Type', column: 'contact_logs.sms_log_type' },
       { label: 'From' },
       { label: 'To' },
       { label: 'Record' },
       { label: 'Content', column: 'contact_logs.content' },
       { label: 'Notified on Failure?' },
       { label: 'Success?' }]
    end

    def record_type_options
      ContactLog.group(:record_type).select(:record_type).order(:record_type).pluck(:record_type)
    end

    def date_filter
      { start_input_label: 'Start Date',
        end_input_label: 'End Date',
        column: :created_at,
        default_start_value: Date.current,
        default_end_value: Date.current,
        type: RadCommon::DateFilter }
    end

    def user_filter(label, column, scope = nil)
      UserGrouper.new(current_user).user_filter(label, column, scope)
    end
end
