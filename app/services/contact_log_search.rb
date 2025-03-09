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
       user_filter('To User', 'contact_log_recipients.to_user_id'),
       { input_label: 'Record Type', column: 'contact_logs.record_type', options: record_type_options },
       { input_label: 'Record ID', column: :record_id, type: RadCommon::EqualsFilter, data_type: :integer },
       { input_label: 'Associated User',
         column: 'associated_with_user',
         grouped: true,
         options: UserGrouper.new(current_user).call,
         scope: :associated_with_user,
         blank_value_label: 'All Users' },
       { input_label: 'Content', column: 'content', type: RadCommon::LikeFilter },
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
      { start_input_label: 'Start Date', end_input_label: 'End Date', column: :created_at, type: RadCommon::DateFilter }
    end

    def user_filter(label, column)
      { input_label: label,
        column: column,
        grouped: true,
        options: UserGrouper.new(current_user).call,
        blank_value_label: 'All Users' }
    end
end
