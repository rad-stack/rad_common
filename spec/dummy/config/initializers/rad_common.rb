Rails.application.config.assets.precompile += %w[rad_common/radbear_mailer.css rad_common/radbear_mailer_reset.css]

Rails.configuration.use_avatar = true
Rails.configuration.external_users = true
Rails.configuration.authy_user_opt_in = true
Rails.configuration.app_logo_includes_name = true
Rails.configuration.portal_namespace = nil
Rails.configuration.system_usage_models = %w[Division User]
Rails.configuration.additional_user_params = []

# TODO: would be better to have this configuration exist inside the policies
Rails.configuration.restricted_audit_attributes = [{ model: 'Division', attribute: 'hourly_rate' }]

Rails.configuration.global_validity_days = 3
Rails.configuration.global_validity_timeout = 1.hour
Rails.configuration.global_validity_exclude = []
Rails.configuration.global_validity_include = []
Rails.configuration.global_validity_supress = []
Rails.configuration.global_validity_enable_interactive = true

Devise.setup do |config|
  config.mailer = 'RadbearDeviseMailer'
end

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.audited associated_with: :record
end

if ENV.fetch('STAGING') == 'true'
  class ChangeStagingEmailSubject
    def self.delivering_email(mail)
      mail.subject = '[STAGING] ' + mail.subject
    end
  end

  ActionMailer::Base.register_interceptor(ChangeStagingEmailSubject)
end

Rails.configuration.global_search_scopes =
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
