class LoginActivitySearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: LoginActivity.recent_first,
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
     { input_label: 'Email',
       joins: 'LEFT JOIN users ON users.id = login_activities.user_id',
       column: 'users.email',
       options:
          [['Users', user_emails],
           ['Clients', client_emails],
           ['Inactive', inactive_user_emails]],
       blank_value_label: 'All Emails',
       grouped: true },
     { input_label: 'Login Status',
       name: :status,
       scope_values: { 'Failure': :failure, 'Success': :successful },
       blank_value_label: 'All' },
     { input_label: 'Failure Reason',
       column: :failure_reason,
       options: failure_reasons,
       blank_value_label: 'All' },
     { input_label: 'IP',
       column: :ip,
       options: login_activity_ips },
     { input_label: 'Agent',
       column: :user_agent,
       options: login_activity_agents },
     { input_label: 'Referrer',
       column: :referrer,
       options: login_activity_referrers }]
  end

  def sort_columns_def
    [{ label: 'When', column: 'created_at', direction: 'desc', default: true },
     { label: 'Email', column: 'email' },
     { label: 'Success' },
     { label: 'Failure', column: 'failure_reason' },
     { label: 'IP', column: 'ip' },
     { label: 'Agent', column: 'user_agent' },
     { label: 'Referrer', column: 'referrer' }]
  end

  def client_emails
    Pundit.policy_scope!(current_user, User).active.external.order(email: :asc).map(&:email)
  end

  def user_emails
    Pundit.policy_scope!(current_user, User).active.internal.order(email: :asc).map(&:email)
  end

  def inactive_user_emails
    Pundit.policy_scope!(current_user, User).inactive.order(email: :asc).map(&:email)
  end

  def login_activity_ips
    Pundit.policy_scope!(current_user, LoginActivity).map(&:ip).uniq
  end

  def login_activity_agents
    Pundit.policy_scope!(current_user, LoginActivity).map { |activity| activity.user_agent.truncate(30) }.uniq
  end

  def login_activity_referrers
    Pundit.policy_scope!(current_user, LoginActivity).map(&:referrer).uniq
  end

  def failure_reasons
    Pundit.policy_scope!(current_user, LoginActivity).failure.map(&:failure_reason).uniq
  end
end
