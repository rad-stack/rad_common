module RadCommon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc 'Used to install the rad_common depencency files and create migrations.'

      def create_initializer_file
        # initializers
        template '../../../../../spec/dummy/config/initializers/rad_common.rb', 'config/initializers/rad_common.rb'

        # locales
        template '../../../../../spec/dummy/config/locales/devise.authy.en.yml', 'config/locales/devise.authy.en.yml'

        # controllers
        template '../../../../../spec/dummy/app/controllers/application_controller.rb', 'app/controllers/application_controller.rb'

        # models
        template '../../../../../spec/dummy/app/models/user.rb', 'app/models/user.rb'
        template '../../../../../spec/dummy/app/models/company.rb', 'app/models/company.rb'
        template '../../../../../spec/dummy/app/models/security_role.rb', 'app/models/security_role.rb'

        # authorizers
        template '../../../../../spec/dummy/app/authorizers/application_authorizer.rb', 'app/authorizers/application_authorizer.rb'

        # views
        template '../../../../../spec/dummy/app/views/devise/confirmations/new.html.haml', 'app/views/devise/confirmations/new.html.haml'
        template '../../../../../spec/dummy/app/views/devise/passwords/edit.html.haml', 'app/views/devise/passwords/edit.html.haml'
        template '../../../../../spec/dummy/app/views/devise/passwords/new.html.haml', 'app/views/devise/passwords/new.html.haml'
        template '../../../../../spec/dummy/app/views/devise/registrations/edit.html.haml', 'app/views/devise/registrations/edit.html.haml'
        template '../../../../../spec/dummy/app/views/devise/registrations/new.html.haml', 'app/views/devise/registrations/new.html.haml'
        template '../../../../../spec/dummy/app/views/devise/sessions/new.html.haml', 'app/views/devise/sessions/new.html.haml'
        template '../../../../../spec/dummy/app/views/devise/shared/_links.html.haml', 'app/views/devise/shared/_links.html.haml'
        template '../../../../../spec/dummy/app/views/devise/unlocks/new.html.haml', 'app/views/devise/unlocks/new.html.haml'
        template '../../../../../spec/dummy/app/views/devise/invitations/new.html.haml', 'app/views/devise/invitations/new.html.haml'
        template '../../../../../spec/dummy/app/views/devise/invitations/edit.html.haml', 'app/views/devise/invitations/edit.html.haml'

        # specs
        template '../../../../../spec/models/company_spec.rb', 'spec/models/company_spec.rb'
        template '../../../../../spec/models/user_spec.rb', 'spec/models/user_spec.rb'
        template '../../../../../spec/models/security_roles_user_spec.rb', 'spec/models/security_roles_user_spec.rb'
        template '../../../../../spec/models/notifications/global_validity_notification_spec.rb', 'spec/models/notifications/global_validity_notification_spec.rb'
        template '../../../../../spec/models/notifications/new_user_signed_up_notification_spec.rb', 'spec/models/notifications/new_user_signed_up_notification_spec.rb'
        template '../../../../../spec/models/notification_type_spec.rb', 'spec/models/notification_type_spec.rb'
        template '../../../../../spec/models/notifications/user_was_approved_notification_spec.rb', 'spec/models/notifications/user_was_approved_notification_spec.rb'
        template '../../../../../spec/requests/users/confirmations_spec.rb', 'spec/requests/users/confirmations_spec.rb'
        template '../../../../../spec/requests/users_spec.rb', 'spec/requests/users_spec.rb'
        template '../../../../../spec/requests/security_roles_spec.rb', 'spec/requests/security_roles_spec.rb'
        template '../../../../../spec/requests/companies_spec.rb', 'spec/requests/companies_spec.rb'
        template '../../../../../spec/requests/searches_spec.rb', 'spec/requests/searches_spec.rb'
        template '../../../../../spec/system/audit_history_spec.rb', 'spec/system/audit_history_spec.rb'
        template '../../../../../spec/system/audit_search_spec.rb', 'spec/system/audit_search_spec.rb'
        template '../../../../../spec/system/users_spec.rb', 'spec/system/users_spec.rb'
        template '../../../../../spec/system/companies_spec.rb', 'spec/system/companies_spec.rb'
        template '../../../../../spec/system/security_roles_spec.rb', 'spec/system/security_roles_spec.rb'
        template '../../../../../spec/system/invitations_spec.rb', 'spec/system/invitations_spec.rb'
        template '../../../../../spec/requests/notification_settings_spec.rb', 'spec/requests/notification_settings_spec.rb'
        template '../../../../../spec/system/notification_settings_spec.rb', 'spec/system/notification_settings_spec.rb'

        # factories
        template '../../../../../spec/factories/companies.rb', 'spec/factories/companies.rb'
        template '../../../../../spec/factories/notification_security_roles.rb', 'spec/factories/notification_security_roles.rb'
        template '../../../../../spec/factories/notification_settings.rb', 'spec/factories/notification_settings.rb'
        template '../../../../../spec/factories/notification_types.rb', 'spec/factories/notification_types.rb'
        template '../../../../../spec/factories/security_roles.rb', 'spec/factories/security_roles.rb'
        template '../../../../../spec/factories/security_roles_users.rb', 'spec/factories/security_roles_users.rb'
        template '../../../../../spec/factories/user_statuses.rb', 'spec/factories/user_statuses.rb'
        template '../../../../../spec/factories/users.rb', 'spec/factories/users.rb'

        # templates

        # active_record templates
        copy_file '../../../../../spec/dummy/lib/templates/active_record/model/model.rb', 'lib/templates/active_record/model/model.rb'

        # haml` templates
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/_form.html.haml', 'lib/templates/haml/scaffold/_form.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/edit.html.haml', 'lib/templates/haml/scaffold/edit.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/index.html.haml', 'lib/templates/haml/scaffold/index.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/new.html.haml', 'lib/templates/haml/scaffold/new.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/show.html.haml', 'lib/templates/haml/scaffold/show.html.haml'

        # rails templates
        copy_file '../../../../../spec/dummy/lib/templates/rails/scaffold_controller/controller.rb', 'lib/templates/rails/scaffold_controller/controller.rb'

        # rspec templates
        copy_file '../../../../../spec/dummy/lib/templates/rspec/integration/request_spec.rb', 'lib/templates/rspec/integration/request_spec.rb'
        copy_file '../../../../../spec/dummy/lib/templates/rspec/system/system_spec.rb', 'lib/templates/rspec/system/system_spec.rb'

        gsub_file 'config/environments/production.rb', '#config.force_ssl = true', 'config.force_ssl = true'

        inject_into_class 'config/application.rb', 'Application' do <<-'RUBY'

    # added by rad_common
    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
      g.controller_specs false
    end

    Rails.configuration.app_admin_email = 'Radical Bear Admin <admin@radicalbear.com>'

        RUBY
        end

        inject_into_file 'config/routes.rb', after: 'Application.routes.draw do' do <<-'RUBY'

  mount RadCommon::Engine => '/rad_common'

  devise_for :users, controllers: { confirmations: 'users/confirmations', invitations: 'users/invitations' }

  resources :users, only: %i[index show edit update destroy] do
    member do
      put :resend_invitation
      put :confirm
      get :audit
      get :audit_by
    end

    get :audit_search, on: :collection
  end

  resources :security_roles do
    get :audit, on: :member
    get :permission, on: :collection
  end

  resources :companies, only: %i[show edit update] do
    get :audit, on: :member
  end

  root to: 'pages#home'

        RUBY
        end

        apply_migration '../../../../../spec/dummy/db/migrate/20140302111111_add_radbear_user_fields.rb', 'add_radbear_user_fields'
        apply_migration '../../../../../spec/dummy/db/migrate/20140827111111_add_name_index_to_users.rb', 'add_name_index_to_users'
        apply_migration '../../../../../spec/dummy/db/migrate/20140903124700_expand_facebook_access_token.rb', 'expand_facebook_access_token'
        apply_migration '../../../../../spec/dummy/db/migrate/20141029233028_add_company_table.rb', 'add_company_table'
        apply_migration '../../../../../spec/dummy/db/migrate/20141110200841_add_logo_stuff_to_company.rb', 'add_logo_stuff_to_company'
        apply_migration '../../../../../spec/dummy/db/migrate/20150221211338_add_optional_emails.rb', 'add_optional_emails'
        apply_migration '../../../../../spec/dummy/db/migrate/20150810232946_add_user_global_search_default.rb', 'add_user_global_search_default'
        apply_migration '../../../../../spec/dummy/db/migrate/20150916175409_remove_twitter.rb', 'remove_twitter'
        apply_migration '../../../../../spec/dummy/db/migrate/20160929174209_add_string_limits.rb', 'add_string_limits'
        apply_migration '../../../../../spec/dummy/db/migrate/20170702133404_company_validity_check.rb', 'company_validity_check'
        apply_migration '../../../../../spec/dummy/db/migrate/20170811123959_security_groups.rb', 'security_groups'
        apply_migration '../../../../../spec/dummy/db/migrate/20171122123931_user_statuses.rb', 'user_statuses'
        apply_migration '../../../../../spec/dummy/db/migrate/20171230132438_super_search_default.rb', 'super_search_default'
        apply_migration '../../../../../spec/dummy/db/migrate/20180314163722_devise_authy_add_to_users.rb', 'devise_authy_add_to_users'
        apply_migration '../../../../../spec/dummy/db/migrate/20180411144821_convert_to_roles.rb', 'convert_to_roles'
        apply_migration '../../../../../spec/dummy/db/migrate/20180509112357_remove_optional_emails.rb', 'remove_optional_emails'
        apply_migration '../../../../../spec/dummy/db/migrate/20180526160907_require_user_names.rb', 'require_user_names'
        apply_migration '../../../../../spec/dummy/db/migrate/20180609150231_company_valid_domains.rb', 'company_valid_domains'
        apply_migration '../../../../../spec/dummy/db/migrate/20180925214758_remove_rad_common_unused_fields.rb', 'remove_rad_common_unused_fields'
        apply_migration '../../../../../spec/dummy/db/migrate/20190130182443_remove_logo_settings.rb', 'remove_logo_settings'
        apply_migration '../../../../../spec/dummy/db/migrate/20190225194928_devise_invitable_add_to_users.rb', 'devise_invitable_add_to_users'
        apply_migration '../../../../../spec/dummy/db/migrate/20190318115634_user_notifications.rb', 'user_notifications'
        apply_migration '../../../../../spec/dummy/db/migrate/20190429211944_remove_super_search_from_users.rb', 'remove_super_search_from_users'
        apply_migration '../../../../../spec/dummy/db/migrate/20190524132649_refactor_notifications.rb', 'refactor_notifications'
      end

      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        if ActiveRecord::Base.timestamped_migrations
          [Time.now.utc.strftime('%Y%m%d%H%M%S'), '%.14d' % next_migration_number].max
        else
          '%.3d' % next_migration_number
        end
      end

      protected

        def apply_migration(source, filename)
          if self.class.migration_exists?('db/migrate', filename)
            say_status('skipped', "Migration #{filename}.rb already exists")
          else
            migration_template source, "db/migrate/#{filename}.rb"
          end
        end

    end
  end
end
