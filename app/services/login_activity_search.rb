class LoginActivitySearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: LoginActivity,
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
       type: RadCommon::DateFilter},
     { input_label: 'Email',
       joins: 'JOIN users ON users.id = login_activities.user_id',
       column: 'users.email',
       options:
          [['Users', user_emails],
           ['Clients', client_emails],
           ['Inactive', inactive_user_emails]],
       blank_value_label: 'All Emails',
       grouped: true }]
  end

  def sort_columns_def
    [{ label: 'When' },
     { label: 'Email' },
     { label: 'Login Status'},
     { label: 'IP' },
     { label: 'Agent' },
     { label: 'Referrer' }]
  end

  def client_emails
    Pundit.policy_scope!(current_user, User).active.external.order(email: :asc).map{ |user| user.email }
  end

  def user_emails
    Pundit.policy_scope!(current_user, User).active.internal.order(email: :asc).map{ |user| user.email }
  end

  def inactive_user_emails
    Pundit.policy_scope!(current_user, User).inactive.order(email: :asc).map{ |user| user.email }
  end
end
