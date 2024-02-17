module RadCommon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('templates', __dir__)
      desc 'Used to install the rad_common depencency files and create migrations.'

      def create_initializer_file
        remove_file 'app/views/layouts/_navigation.html.haml'
        remove_file 'config/initializers/new_framework_defaults_7_0.rb'
        remove_file 'app/models/application_record.rb'
        remove_file '.hound.yml'

        remove_deprecated_config
        add_crawling_config
        install_procfile
        standardize_date_methods
        install_database_yml
        install_github_workflow
        update_seeder_method

        search_and_replace '= f.error_notification', '= rad_form_errors f'

        # misc
        merge_package_json
        copy_custom_github_actions
        copy_custom_github_matrix
        copy_file '../../../../../spec/dummy/Rakefile', 'Rakefile'
        copy_file '../../../../../spec/dummy/babel.config.js', 'babel.config.js'
        copy_file '../../../../../spec/dummy/.nvmrc', '.nvmrc'
        copy_file '../gitignore.txt', '.gitignore'
        copy_file '../pull_request_template.md', '.github/pull_request_template.md'
        copy_file '../rails_helper.rb', 'spec/rails_helper.rb'
        copy_file '../../../../../spec/dummy/public/403.html', 'public/403.html'
        copy_file '../../../../../spec/dummy/app/javascript/packs/application.js', 'app/javascript/packs/application.js'
        copy_file '../../../../../spec/dummy/app/javascript/packs/rad_mailer.js', 'app/javascript/packs/rad_mailer.js'
        directory '../../../../../.bundle', '.bundle'

        # code style config
        copy_file '../../../../../.haml-lint.yml', '.haml-lint.yml'
        copy_file '../../../../../.sniff.yml', '.sniff.yml'
        copy_file '../../../../../.eslintrc', '.eslintrc'
        copy_file '../../../../../.stylelintrc.json', '.stylelintrc.json'

        # config
        unless RadConfig.storage_config_override?
          copy_file '../../../../../spec/dummy/config/storage.yml', 'config/storage.yml'
        end

        copy_file '../../../../../spec/dummy/config/application.rb', 'config/application.rb'
        gsub_file 'config/application.rb', 'Dummy', installed_app_name.classify

        copy_file '../../../../../spec/dummy/config/webpacker.yml', 'config/webpacker.yml'
        copy_file '../../../../../spec/dummy/config/puma.rb', 'config/puma.rb'
        copy_file '../../../../../spec/dummy/config/sidekiq.yml', 'config/sidekiq.yml'
        directory '../../../../../spec/dummy/config/environments/', 'config/environments/'
        directory '../../../../../spec/dummy/config/webpack/', 'config/webpack/'
        template '../../../../../spec/dummy/config/initializers/devise.rb', 'config/initializers/devise.rb'

        template '../../../../../spec/dummy/config/initializers/devise_security.rb',
                 'config/initializers/devise_security.rb'

        copy_file '../../../../../spec/dummy/config/initializers/simple_form.rb',
                  'config/initializers/simple_form.rb'

        copy_file '../../../../../spec/dummy/config/initializers/simple_form_bootstrap.rb',
                  'config/initializers/simple_form_bootstrap.rb'

        copy_file '../../../../../spec/dummy/config/initializers/simple_form_components.rb',
                  'config/initializers/simple_form_components.rb'

        # bin
        directory '../../../../../spec/dummy/bin/', 'bin/'

        # locales
        copy_file '../../../../../spec/dummy/config/locales/devise.twilio_verify.en.yml',
                  'config/locales/devise.twilio_verify.en.yml'
        copy_file '../../../../../spec/dummy/config/locales/devise_invitable.en.yml',
                  'config/locales/devise_invitable.en.yml'
        copy_file '../../../../../spec/dummy/config/locales/devise.en.yml', 'config/locales/devise.en.yml'
        copy_file '../../../../../spec/dummy/config/locales/simple_form.en.yml',
                  'config/locales/simple_form.en.yml'

        # specs
        directory '../../../../../spec/factories/rad_common/',
                  'spec/factories/rad_common/',
                  exclude_pattern: /clients.rb/

        copy_file '../../../../../spec/fixtures/test_photo.png', 'spec/fixtures/test_photo.png'

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

        create_file 'db/seeds.rb' do <<-'RUBY'
require 'factory_bot_rails'

Seeder.new.seed!
        RUBY
        end

        inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do <<-'RUBY'

  mount RadCommon::Engine => '/rad_common'
  extend RadCommonRoutes

        RUBY
        end

        inject_into_file 'Gemfile', after: "gem 'rubocop', require: false\n" do <<-'RUBY'
  gem 'rubocop-capybara'
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
        apply_migration '20211202111615_fix_audits_index.rb'
        apply_migration '20220121140559_create_user_clients.rb'
        apply_migration '20220202173640_authy_no_sms.rb'
        apply_migration '20220328202539_manage_users_perm.rb'
        apply_migration '20220405182602_optional_mobile_phone.rb'
        apply_migration '20220423173413_inactive_notifications.rb'
        apply_migration '20220504114538_rename_validate_email.rb'
        apply_migration '20220719162246_address_validation.rb'
        apply_migration '20220901143808_sign_up_roles.rb'
        apply_migration '20220905140634_allow_invite_role.rb'
        apply_migration '20220918194026_refine_smarty.rb'
        apply_migration '20221021113251_create_saved_search_filters.rb'
        apply_migration '20221108110620_add_new_audited_changes_to_audits.rb'
        apply_migration '20221123142522_twilio_log_changes.rb'
        apply_migration '20221108114020_convert_audited_changes_text_to_json.rb'
        apply_migration '20221221134935_remove_legacy_audited_changes.rb'
        apply_migration '20230222162024_migrate_authy_to_twilio_verify.rb'
        apply_migration '20230310161506_more_twilio_verify.rb'
        apply_migration '20230313195243_add_language.rb'
        apply_migration '20230401113151_fix_sendgrid_notification.rb'
        apply_migration '20230419121743_twilio_replies.rb'
        apply_migration '20230420102508_update_twilio_log_number_format.rb'
        apply_migration '20230425215920_create_twilio_log_attachments.rb'
        apply_migration '20231205185433_pending_user_status.rb'
        apply_migration '20240209141219_missing_fks.rb'
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

        def merge_package_json
          dummy_file_path = '../../../../../spec/dummy/package.json'
          return copy_file dummy_file_path, 'package.json' unless File.exist? 'custom-dependencies.json'

          custom_dependencies = JSON.parse(File.read('custom-dependencies.json'))
          package_source = File.expand_path(find_in_source_paths(dummy_file_path))
          package = JSON.parse(File.read(package_source))
          dependencies = package['dependencies']
          dependencies = dependencies.merge(custom_dependencies)
          package['dependencies'] = dependencies
          File.write('package.json', JSON.pretty_generate(package) + "\n")
        end

        def copy_custom_github_actions
          dummy_action_path = '../../../../../.github/actions/custom-action/action.yml'
          new_action_path = '.github/actions/custom-action/action.yml'
          return if File.exist? new_action_path

          copy_file dummy_action_path, new_action_path
        end

        def copy_custom_github_matrix
          dummy_matrix_path = '../../../../../.github/actions/custom_matrix.json'
          new_matrix_path = '.github/actions/custom_matrix.json'
          return if File.exist? new_matrix_path

          copy_file dummy_matrix_path, new_matrix_path
        end

        def apply_migration(source)
          filename = source.split('_').drop(1).join('_').gsub('.rb', '')

          if self.class.migration_exists?('db/migrate', filename)
            say_status('skipped', "Migration #{filename}.rb already exists")
          else
            migration_template "../../../../../spec/dummy/db/migrate/#{source}",
                               "db/migrate/#{filename}.rb"
          end
        end

        def search_and_replace(search, replace, js: false)
          system "find . -type f -name \"*.rb\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          system "find . -type f -name \"*.haml\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          system "find . -type f -name \"*.rake\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          return unless js

          system "find . -type f -name \"*.js\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
        end

        def remove_deprecated_config
          # TODO: refactor these methods to manipulate rad_common.yml
          gsub_file 'config/rad_common.yml', 'shared_database: false', ''
        end

        def add_crawling_config
          remove_file 'public/robots.txt'

          # TODO: refactor these methods to manipulate rad_common.yml
          standard_config_end = /\n(  system_usage_models:)/
          new_config = "  allow_crawling: false\n  always_crawl: false\n  crawling_subdomains: []\n\n"
          config_file = 'config/rad_common.yml'

          unless File.readlines(config_file).grep(/allow_crawling:/).any?
            gsub_file config_file, standard_config_end, "#{new_config}\\1"
          end
        end

        def install_procfile
          # TODO: refactor these methods to manipulate rad_common.yml
          standard_config_end = /\n(  system_usage_models:)/
          new_config = "  procfile_override: false\n\n\n"
          config_file = 'config/rad_common.yml'

          unless File.readlines(config_file).grep(/procfile_override:/).any?
            gsub_file config_file, standard_config_end, "#{new_config}\\1"
            return
          end

          return if RadConfig.procfile_override?

          copy_file '../../../../../spec/dummy/Procfile', 'Procfile'
        end

        def update_seeder_method
          file_path = 'app/services/seeder.rb'
          if File.exist?(file_path)
            gsub_file file_path, /def seed!\n\s*super\n?/, 'def seed'
            say_status('updated', "#{file_path} to use new seed method")
          else
            say_status('skipped', "File #{file_path} does not exist")
          end
        end

        def standardize_date_methods
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
        end

        def install_database_yml
          copy_file '../../../../../spec/dummy/config/database.yml', 'config/temp_database.yml'
          gsub_file 'config/temp_database.yml', 'rad_common_', "#{installed_app_name}_"
          copy_file Rails.root.join('config/temp_database.yml'), 'config/database.yml'
          remove_file Rails.root.join('config/temp_database.yml')
        end

        def install_github_workflow
          copy_file '../../../../../.github/workflows/rspec_tests.yml', '.github/workflows/rspec_tests.yml'
          copy_file '../../../../../.github/workflows/rad_update_bot.yml', '.github/workflows/rad_update_bot.yml'
          remove_file '.github/workflows/rc_update.yml'
          gsub_file '.github/workflows/rspec_tests.yml', 'rad_common_test', "#{installed_app_name}_test"
          gsub_file '.github/workflows/rad_update_bot.yml', 'rad_common_development', "#{installed_app_name}_development"
          gsub_file '.github/workflows/rspec_tests.yml', /^\s*working-directory: spec\/dummy\s*\n/, ''
          gsub_file '.github/workflows/rspec_tests.yml',
                   "bundle exec parallel_rspec spec --exclude-pattern 'templates/rspec/*.*'",
                   'bin/rc_parallel_rspec'
        end

        def installed_app_name
          ::Rails.application.class.module_parent.to_s.underscore
        end
    end
  end
end
