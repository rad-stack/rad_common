RadCommon.setup do |config|
  config.use_avatar = true
  config.external_users = true
  config.authy_user_opt_in = true
  config.app_logo_includes_name = true
  config.system_usage_models = %w[Division User]
  config.restricted_audit_attributes = [{ model: 'Division', attribute: 'hourly_rate' }]
  config.global_search_scopes =
    [
      { name: 'user_name', model: 'User',
        description: 'Search user by name',
        columns: ['email'],
        methods: [:user_status],
        query_where: "last_name || ', ' || first_name ilike :search",
        query_order: 'last_name ASC, first_name ASC, created_at DESC' },
      { name: 'user_email', model: 'User',
        description: 'Search user by email',
        columns: ['email'],
        query_where: 'email ilike :search' },
      { name: 'user_name_with_no_where', model: 'User',
        description: 'Search user by name',
        columns: [],
        query_order: 'last_name ASC, first_name ASC, created_at DESC' },
      { name: 'division_name', model: 'Division',
        description: 'Search division by name',
        columns: ['name'],
        query_where: 'name ilike :search',
        query_order: 'name' },
      { name: 'user_by_division_name', model: 'User',
        description: 'Search user by division name',
        columns: [],
        joins: 'JOIN divisions on divisions.owner_id = users.id',
        query_where: 'divisions.name ilike :search',
        super_search_exclude: true }
    ]
end
