require 'rad_common/engine'

module RadCommon
  # Enables/Disables user avatars being uploaded and displayed in the application
  cattr_accessor :use_avatar
  @@use_avatar = false

  # Does not allow users to manually sign up
  cattr_accessor :disable_sign_up
  @@disable_sign_up = false

  # Allows users to be marked as external/client users, adjusts user filtering and seeds to account for this
  cattr_accessor :external_users
  @@external_users = false

  # Allows for two-factor authentication to be enabled for users
  cattr_accessor :authy_user_opt_in
  @@authy_user_opt_in = false

  # Only includes company name in email header if app logo does not include name
  cattr_accessor :app_logo_includes_name
  @@app_logo_includes_name = true

  # Set to namespace for portal users. This is needed to control authentication.
  cattr_accessor :portal_namespace
  @@portal_namespace = nil

  # Determines which models should be included in the system_usages route
  cattr_accessor :system_usage_models
  @@system_usage_models = []

  # Determines which attributes should be hidden in the audits for non-admin users
  cattr_accessor :restricted_audit_attributes
  @@restricted_audit_attributes = []

  # allows for additional parameters to be passed into the users controller thus
  # avoiding the need to override the controller in many cases)
  cattr_accessor :additional_user_params
  @@additional_user_params = []

  # Determines how ofter the global validity check will run
  cattr_accessor :global_validity_days
  @@global_validity_days = 3

  # Sets the time allowed for the global validity to run before timing out / raising an error
  cattr_accessor :global_validity_timeout
  @@global_validity_timeout = 3.hours

  # Determines models to be excluded in the global validity check
  cattr_accessor :global_validity_exclude
  @@global_validity_exclude = []

  # Allows for queries to be passed in, providing the ability to exclude records of specific class
  # This is typically used in combination with global_validity_exclude
  cattr_accessor :global_validity_include
  @@global_validity_include = []

  # Allows for specific messages to be excluded from the global validity emailed result
  cattr_accessor :global_validity_supress
  @@global_validity_supress = []

  # Allows for manual trigger of global validity check on the company show pay
  cattr_accessor :global_validity_enable_interactive
  @@global_validity_enable_interactive = true

  # Sets search scopes to be included in the navigation search bar
  cattr_accessor :global_search_scopes
  @@global_search_scopes = []

  def self.setup
    yield self
  end
end
