require 'rad_common/engine'

module RadCommon
  cattr_accessor :use_avatar
  @@use_avatar = false

  cattr_accessor :disable_sign_up
  @@disable_sign_up = false

  cattr_accessor :external_users
  @@external_users = false

  cattr_accessor :authy_user_opt_in
  @@authy_user_opt_in = true

  cattr_accessor :app_logo_includes_name
  @@app_logo_includes_name = true

  cattr_accessor :portal_namespace
  @@portal_namespace = nil

  cattr_accessor :system_usage_models
  @@system_usage_models = %w[User]

  cattr_accessor :restricted_audit_attributes
  @@restricted_audit_attributes = []

  cattr_accessor :additional_user_params
  @@additional_user_params = []

  cattr_accessor :global_validity_days
  @@global_validity_days = 3

  cattr_accessor :global_validity_timeout
  @@global_validity_timeout = 3.hours

  cattr_accessor :global_validity_exclude
  @@global_validity_exclude = []

  cattr_accessor :global_validity_include
  @@global_validity_include = []

  cattr_accessor :global_validity_supress
  @@global_validity_supress = []

  cattr_accessor :global_validity_enable_interactive
  @@global_validity_enable_interactive = true

  cattr_accessor :global_search_scopes
  @@global_search_scopes = []

  def self.setup
    yield self
  end
end
