class NotificationSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: Notification.joins(:notification_type, :user),
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def filters_def
      items = []

      if current_user.admin?
        items.push({ input_label: 'User',
                     column: 'user_id',
                     grouped: true,
                     options: UserGrouper.new(current_user, scopes: [:with_notifications]).call,
                     default_value: current_user.id })
      end

      items + [{ start_input_label: 'Start Date',
                 end_input_label: 'End Date',
                 column: :created_at,
                 type: RadCommon::DateFilter },
               { column: 'notification_type_id', options: notification_type_options },
               { column: 'content', type: RadCommon::LikeFilter },
               { input_label: 'Record Type', column: 'record_type', options: record_type_options },
               { input_label: 'Record ID', column: 'record_id', type: RadCommon::EqualsFilter, data_type: :integer },
               { input_label: 'Status',
                 name: :status,
                 scope_values: %i[unread],
                 blank_value_label: 'All Notifications',
                 default_value: :unread }]
    end

    def sort_columns_def
      items = []

      items.push({ column: 'users.first_name, users.last_name', label: 'User' }) if current_user.admin?

      items + [{ label: 'When', column: 'notifications.created_at', direction: 'desc', default: true },
               { label: 'Type', column: 'notification_types.type' },
               { column: 'Content' },
               { label: 'Subject' },
               { label: 'Actions' }]
    end

    def notification_type_options
      NotificationType.joins(:notifications).distinct.sorted
    end

    def record_type_options
      Notification.group(:record_type).select(:record_type).order(:record_type).pluck(:record_type)
    end
end
