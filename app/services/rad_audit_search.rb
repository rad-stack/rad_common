class RadAuditSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: RadAudit,
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
       { input_label: 'Record Type',
         column: :auditable_type,
         options: RadCommon::AppInfo.new.audited_models },
       { input_label: 'User',
         column: :user_id,
         options:
             [['Default', [current_user, { scope_value: :system_generated }]],
              ['Users', users],
              ['Clients', client_users],
              ['Inactive', inactive_users]],
         blank_value_label: 'All Users', grouped: true },
       { column: :remote_address, type: RadCommon::LikeFilter }]
    end

    def sort_columns_def
      [{ label: 'Date', column: 'created_at', direction: 'desc', default: true },
       { label: 'Record Type', column: 'auditable_type' },
       { label: 'Record ID', column: 'auditable_id' },
       { label: 'User' },
       { label: 'Remote Address', column: 'remote_address' },
       { label: 'Action' },
       { label: 'Changes' }]
    end

    def users
      Pundit.policy_scope!(current_user, User).active.internal.by_name.where.not(id: current_user.id)
    end

    def client_users
      Pundit.policy_scope!(current_user, User).active.external.by_name
    end

    def inactive_users
      Pundit.policy_scope!(current_user, User).inactive.by_name
    end
end
