Rails.application.config.assets.precompile += %w[rad_common/radbear_mailer.css rad_common/radbear_mailer_reset.css]

Rails.configuration.enable_facebook = true
Rails.configuration.use_avatar = false
Rails.configuration.authy_user_opt_in = true

Rails.configuration.global_validity_days = 3
Rails.configuration.global_validity_timeout = 1.hour
Rails.configuration.global_validity_exclude = []
Rails.configuration.global_validity_include = []
Rails.configuration.global_validity_supress = []

Devise.setup do |config|
  config.mailer = 'RadbearDeviseMailer'
end

Rails.configuration.global_search_scopes =
  [
    { name: 'user_name', model: User,
      description: 'Search for user by name',
      columns: ['email'],
      query_where: "last_name || ', ' || first_name ilike :search",
      query_order: 'last_name ASC, first_name ASC, created_at DESC' },
    { name: 'user_email', model: User,
      description: 'Search for user by email',
      columns: ['email'],
      query_where: "email ilike :search",
    },
    { name: 'user_name_with_no_where', model: User,
      description: 'Search for user by name',
      columns: [],
      query_order: 'last_name ASC, first_name ASC, created_at DESC' },
    { name: 'division_name', model: Division,
      description: 'Search for division by name',
      columns: ['name'],
      query_where: 'name ilike :search',
      query_order: 'name'
    }
  ]
