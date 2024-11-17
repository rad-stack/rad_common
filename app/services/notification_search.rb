class NotificationSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: Notification.joins(:notification_type),
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
       { column: 'notification_type_id', options: notification_type_options },
       { column: 'content', type: RadCommon::LikeFilter },
       { input_label: 'Record Type', column: 'record_type', options: record_type_options },
       { input_label: 'Record ID', column: 'record_id', type: RadCommon::EqualsFilter, data_type: :integer }]
    end

    def sort_columns_def
      [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
       { label: 'Type', column: 'notification_types.type' },
       { column: 'Content' },
       { label: 'Subject' }]
    end

    def notification_type_options
      NotificationType.joins(:notifications).where(notifications: { user: current_user }).distinct.sorted
    end

    def record_type_options
      current_user.notifications.group(:record_type).select(:record_type).order(:record_type).pluck(:record_type)
    end
end
