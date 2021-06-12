require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
# require 'action_cable/engine'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require 'rad_common'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.rad_common = config_for(:rad_common)

    config.rad_common[:portal_host_name] = if !Rails.configuration.rad_common[:external_users]
                                             Rails.configuration.rad_common[:host_name]
                                           elsif Rails.env.production?
                                             ENV['PORTAL_HOST_NAME']
                                           else
                                             'portal.localhost:3000'
                                           end

    config.rad_common[:staging] = Rails.env.production? && ENV['STAGING'].present? && ENV['STAGING'] == 'true'
    config.rad_common[:app_name] = ENV['APP_NAME'].presence || 'Demo Foo'
    config.rad_common[:portal_app_name] = ENV['PORTAL_APP_NAME'].presence || 'Foo Portal'

    # Determines which models should be included in the system_usages route
    config.rad_common[:system_usage_models] = [['Division', 'status_pending', 'Pending Divisions'],
                                               ['Division', 'status_active', 'Active Divisions'],
                                               ['Division', 'status_inactive', 'Inactive Divisions'],
                                               'User']

    # Determines which models should be included in the duplicates processing features
    config.rad_common[:duplicates] = { models: [{ name: 'Attorney' }] }

    # Determines which attributes should be hidden in the audits for non-admin users
    config.rad_common[:restricted_audit_attributes] = [{ model: 'Division', attribute: 'hourly_rate' }]

    # allows for additional parameters to be passed into the users controller thus
    # avoiding the need to override the controller in many cases)
    config.rad_common[:additional_user_params] = []

    # Determines how ofter the global validity check will run
    config.rad_common[:global_validity_days] = 3

    # A notification email with a report of how long each item took will be sent if it runs beyond this timeout
    # There is a hard time out of 24 hours which will raise an exception and terminate the rake task
    config.rad_common[:global_validity_timeout] = 3.hours

    # Determines models to be excluded in the global validity check
    config.rad_common[:global_validity_exclude] = []

    # Allows for queries to be passed in, providing the ability to exclude records of specific class
    # This is typically used in combination with global_validity_exclude
    config.rad_common[:global_validity_include] = []

    # Allows for specific messages to be excluded from the global validity emailed result
    config.rad_common[:global_validity_supress] = []

    # Sets search scopes to be included in the navigation search bar
    config.rad_common[:global_search_scopes] =
      [
        { name: 'user_name',
          model: 'User',
          description: 'Search user by name',
          columns: ['email'],
          methods: [:user_status],
          query_where: "last_name || ', ' || first_name ilike :search",
          query_order: 'last_name ASC, first_name ASC, created_at DESC' },

        { name: 'user_email',
          model: 'User',
          description: 'Search user by email',
          columns: ['email'],
          query_where: 'email ilike :search' },

        { name: 'user_name_with_no_where',
          model: 'User',
          description: 'Search user by name',
          columns: [],
          query_order: 'last_name ASC, first_name ASC, created_at DESC' },

        { name: 'division_name',
          model: 'Division',
          description: 'Search division by name',
          columns: ['name'],
          query_where: 'name ilike :search',
          query_order: 'name' },
        { name: 'user_by_division_name',
          model: 'User',
          description: 'Search user by division name',
          columns: [],
          joins: 'JOIN divisions on divisions.owner_id = users.id',
          query_where: 'divisions.name ilike :search',
          super_search_exclude: true }
      ]
  end
end
