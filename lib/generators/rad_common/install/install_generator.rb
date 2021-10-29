module RadCommon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('templates', __dir__)
      desc 'Used to install the rad_common depencency files and create migrations.'

      def create_initializer_file
        search_and_replace 'Time.zone.today', 'Date.current'
        search_and_replace 'DateTime.now', 'Time.current'
        search_and_replace 'Time.now', 'Time.current'
        search_and_replace 'Time.zone.now', 'Time.current'
        search_and_replace 'Date.today', 'Date.current'
        search_and_replace 'Date.tomorrow', 'Time.zone.tomorrow'
        search_and_replace 'Date.yesterday', 'Time.zone.yesterday'

        search_and_replace 'before { login_as(user, scope: :user) }',
                           'before { login_as user, scope: :user }'

        search_and_replace 'before { login_as(admin, scope: :user) }',
                           'before { login_as admin, scope: :user }'

        # misc
        template '../../../../../spec/dummy/Procfile', 'Procfile'
        template '../../../../../spec/dummy/package.json', 'package.json'
        copy_file '../../../../../spec/dummy/babel.config.js', 'babel.config.js'
        template '../../../../../spec/dummy/app/services/seeder.rb', 'app/services/seeder.rb'
        copy_file '../gitignore.txt', '.gitignore'

        # code style config
        copy_file '../../../../../.haml-lint.yml', '.haml-lint.yml'
        copy_file '../../../../../.hound.yml', '.hound.yml'
        copy_file '../../../../../.rubocop.yml', '.rubocop.yml'

        # config
        copy_file '../../../../../spec/dummy/config/storage.yml', 'config/storage.yml'
        directory '../../../../../spec/dummy/config/environments/', 'config/environments/'
        template '../../../../../spec/dummy/config/initializers/devise.rb', 'config/initializers/devise.rb'

        template '../../../../../spec/dummy/config/initializers/devise_security.rb',
                 'config/initializers/devise_security.rb'

        # locales
        template '../../../../../spec/dummy/config/locales/devise.authy.en.yml',
                 'config/locales/devise.authy.en.yml'

        # controllers
        template '../../../../../spec/dummy/app/controllers/application_controller.rb',
                 'app/controllers/application_controller.rb'

        # models
        template '../../../../../spec/dummy/app/models/user.rb', 'app/models/user.rb'
        template '../../../../../spec/dummy/app/models/company.rb', 'app/models/company.rb'
        template '../../../../../spec/dummy/app/models/security_role.rb', 'app/models/security_role.rb'

        # policies
        template '../../../../../spec/dummy/app/policies/application_policy.rb',
                 'app/policies/application_policy.rb'

        # views
        template '../../../../../spec/dummy/app/views/devise/confirmations/new.html.haml',
                 'app/views/devise/confirmations/new.html.haml'

        template '../../../../../spec/dummy/app/views/devise/passwords/edit.html.haml',
                 'app/views/devise/passwords/edit.html.haml'

        template '../../../../../spec/dummy/app/views/devise/passwords/new.html.haml',
                 'app/views/devise/passwords/new.html.haml'

        template '../../../../../spec/dummy/app/views/devise/registrations/edit.html.haml',
                 'app/views/devise/registrations/edit.html.haml'

        template '../../../../../spec/dummy/app/views/devise/registrations/new.html.haml',
                 'app/views/devise/registrations/new.html.haml'

        template '../../../../../spec/dummy/app/views/devise/sessions/new.html.haml',
                 'app/views/devise/sessions/new.html.haml'

        template '../../../../../spec/dummy/app/views/devise/shared/_links.html.haml',
                 'app/views/devise/shared/_links.html.haml'

        template '../../../../../spec/dummy/app/views/devise/unlocks/new.html.haml',
                 'app/views/devise/unlocks/new.html.haml'

        template '../../../../../spec/dummy/app/views/devise/invitations/new.html.haml',
                 'app/views/devise/invitations/new.html.haml'

        template '../../../../../spec/dummy/app/views/devise/password_expired/show.html.haml',
                 'app/views/devise/password_expired/show.html.haml'

        template '../../../../../spec/dummy/app/views/devise/invitations/edit.html.haml',
                 'app/views/devise/invitations/edit.html.haml'

        # specs
        directory '../../../../../spec/rad_common/', 'spec/rad_common/'
        directory '../../../../../spec/factories/rad_common/', 'spec/factories/rad_common/'
        copy_file '../../../../../spec/fixtures/test_photo.png', 'spec/fixtures/test_photo.png'
        copy_file '../../../../../spec/dummy/spec/support/test_helpers.rb', 'spec/support/test_helpers.rb'

        # templates

        # active_record templates
        copy_file '../../../../../spec/dummy/lib/templates/active_record/model/model.rb',
                  'lib/templates/active_record/model/model.rb'

        # haml` templates
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/_form.html.haml',
                  'lib/templates/haml/scaffold/_form.html.haml'

        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/edit.html.haml',
                  'lib/templates/haml/scaffold/edit.html.haml'

        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/index.html.haml',
                  'lib/templates/haml/scaffold/index.html.haml'

        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/new.html.haml',
                  'lib/templates/haml/scaffold/new.html.haml'

        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/show.html.haml',
                  'lib/templates/haml/scaffold/show.html.haml'

        # rails templates
        copy_file '../../../../../spec/dummy/lib/templates/rails/scaffold_controller/controller.rb',
                  'lib/templates/rails/scaffold_controller/controller.rb'

        # rspec templates
        copy_file '../../../../../spec/dummy/lib/templates/rspec/scaffold/request_spec.rb',
                  'lib/templates/rspec/scaffold/request_spec.rb'

        copy_file '../../../../../spec/dummy/lib/templates/rspec/system/system_spec.rb',
                  'lib/templates/rspec/system/system_spec.rb'

        gsub_file 'config/environments/production.rb',
                  '#config.force_ssl = true',
                  'config.force_ssl = true'

        create_file 'db/seeds.rb' do <<-'RUBY'
Seeder.new.seed!
        RUBY
        end

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

        RUBY
        end

        inject_into_file 'config/routes.rb', after: 'Application.routes.draw do' do <<-'RUBY'

  mount RadCommon::Engine => '/rad_common'

  devise_for :users, controllers: { confirmations: 'users/confirmations', invitations: 'users/invitations' }

  resources :users, only: %i[index show edit update destroy] do
    member do
      put :resend_invitation
      put :confirm
    end
  end

  resources :security_roles do
    get :audit, on: :member
    get :permission, on: :collection
  end

  resources :companies, only: %i[show edit update] do
    get :audit, on: :member
  end

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'pages#home'

        RUBY
        end

        apply_migration '20140302111111_add_radbear_user_fields.rb'
        apply_migration '20140827111111_add_name_index_to_users.rb'
        apply_migration '20140903124700_expand_facebook_access_token.rb'
        apply_migration '20141029233028_add_company_table.rb'
        apply_migration '20141110200841_add_logo_stuff_to_company.rb'
        apply_migration '20150221211338_add_optional_emails.rb'
        apply_migration '20150810232946_add_user_global_search_default.rb'
        apply_migration '20150916175409_remove_twitter.rb'
        apply_migration '20160929174209_add_string_limits.rb'
        apply_migration '20170702133404_company_validity_check.rb'
        apply_migration '20170811123959_security_groups.rb'
        apply_migration '20171122123931_user_statuses.rb'
        apply_migration '20171230132438_super_search_default.rb'
        apply_migration '20180314163722_devise_authy_add_to_users.rb'
        apply_migration '20180411144821_convert_to_roles.rb'
        apply_migration '20180509112357_remove_optional_emails.rb'
        apply_migration '20180526160907_require_user_names.rb'
        apply_migration '20180609150231_company_valid_domains.rb'
        apply_migration '20180925214758_remove_rad_common_unused_fields.rb'
        apply_migration '20190130182443_remove_logo_settings.rb'
        apply_migration '20190225194928_devise_invitable_add_to_users.rb'
        apply_migration '20190318115634_user_notifications.rb'
        apply_migration '20190429211944_remove_super_search_from_users.rb'
        apply_migration '20190524132649_refactor_notifications.rb'
        apply_migration '20190810122656_create_system_messages.rb'
        apply_migration '20190829220515_add_message_type_to_system_messages.rb'
        apply_migration '20190911120012_timezones.rb'
        apply_migration '20190919163914_remove_super_admin.rb'
        apply_migration '20190929125052_notification_auth_mode.rb'
        apply_migration '20191112111902_devise_lockable.rb'
        apply_migration '20200128185735_make_message_not_required.rb'
        apply_migration '20200203163827_convert_rich_text.rb'
        apply_migration '20200227134827_create_rad_common_notifications.rb'
        apply_migration '20200306204548_notifications_sti.rb'
        apply_migration '20200311113900_fix_notification_names.rb'
        apply_migration '20200325152933_devise_security_updates.rb'
        apply_migration '20200408180735_ran_long_notification.rb'
        apply_migration '20200526144750_convert_filter_defaults_to_json.rb'
        apply_migration '20200530154123_filter_defaults_for_all.rb'
        apply_migration '20200810143832_create_login_activities.rb'
        apply_migration '20200903192242_rename_security_roles.rb'
        apply_migration '20210104154427_remove_current_phone.rb'
        apply_migration '20210111201627_create_twilio_logs.rb'
        apply_migration '20210119145517_external_security_roles.rb'
        apply_migration '20210126120121_require_twilio_user.rb'
        apply_migration '20210204112040_system_message_role.rb'
        apply_migration '20210419153508_create_duplicates.rb'
        apply_migration '20210428131743_unique_duplicates.rb'
        apply_migration '20210522104137_duplicates_processed.rb'
        apply_migration '20210621112203_opt_out_message_sent.rb'
        apply_migration '20210729135942_authy_always_enabled.rb'
        apply_migration '20210805105809_fix_notification_defaults.rb'
        apply_migration '20211029155622_fix_array_type.rb'
      end

      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        if ActiveRecord::Base.timestamped_migrations
          [Time.current.utc.strftime('%Y%m%d%H%M%S'), '%.14d' % next_migration_number].max
        else
          '%.3d' % next_migration_number
        end
      end

      protected

        def apply_migration(source)
          filename = source.split('_').drop(1).join('_').gsub('.rb', '')

          if self.class.migration_exists?('db/migrate', filename)
            say_status('skipped', "Migration #{filename}.rb already exists")
          else
            migration_template "../../../../../spec/dummy/db/migrate/#{source}",
                               "db/migrate/#{filename}.rb"
          end
        end

        def search_and_replace(search, replace)
          system "find . -type f -name \"*.rb\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          system "find . -type f -name \"*.haml\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          system "find . -type f -name \"*.rake\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
        end
    end
  end
end
