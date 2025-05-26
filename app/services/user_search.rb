class UserSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: query_def,
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def query_def
      if RadConfig.user_clients?
        User.joins(:user_status).left_joins(:clients).includes(:user_status, :security_roles).distinct
      else
        User.joins(:user_status).includes(:user_status, :security_roles)
      end
    end

    def filters_def
      items = [{ column: 'users.first_name', type: RadCommon::LikeFilter, input_label: 'First Name' },
               { column: 'users.last_name', type: RadCommon::LikeFilter, input_label: 'Last Name' },
               { column: 'email', type: RadCommon::LikeFilter, input_label: 'Email' },
               { column: 'mobile_phone', type: RadCommon::LikeFilter, input_label: 'Mobile Phone' }]

      if can_update?
        items.push({ input_label: 'Security Role',
                     scope: :for_security_role,
                     options: SecurityRole.sorted,
                     blank_value_label: 'All Users' })
      end

      items.push({ input_label: 'Status',
                   column: :user_status_id,
                   options: RadConfig.pending_users? ? UserStatus.not_pending.by_id : UserStatus.by_id,
                   default_value: UserStatus.default_active_status.id })

      if RadConfig.external_users? && current_user.internal?
        items.push(input_label: 'Type', name: :external, scope_values: %i[internal external])
      end

      if RadConfig.user_clients?
        items.push(input_label: RadCommon::AppInfo.new.client_model_label,
                   column: "#{RadConfig.client_table_name!}.id", options: clients)
      end

      items
    end

    def sort_columns_def
      items = [{ label: 'Name', column: 'users.first_name, users.last_name', default: !can_update? },
               { column: 'email' },
               { column: 'mobile_phone' }]

      if can_update?
        items += [{ label: 'Signed In', column: 'current_sign_in_at' },
                  { label: 'Created', column: 'users.created_at', direction: 'desc', default: true }]
      end

      items.push({ label: 'Status', column: 'user_statuses.name' })
      items.push({ label: 'Roles' }) if can_update?

      if RadConfig.external_users?
        items.push(label: "#{RadCommon::AppInfo.new.client_model_label}s",
                   column: RadConfig.user_clients? ? nil : 'users.external')
      end

      items
    end

    def can_update?
      Pundit.policy!(current_user, User.new).update?
    end

    def clients
      Pundit.policy_scope!(current_user, RadCommon::AppInfo.new.client_model_class)
            .where('id IN (SELECT client_id FROM user_clients)').sorted
    end
end
