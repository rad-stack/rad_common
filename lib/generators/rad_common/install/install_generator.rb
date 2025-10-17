module RadCommon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('templates', __dir__)
      desc 'Used to install the rad_common dependency files and create migrations.'

      def create_initializer_file
        remove_file 'app/views/layouts/_navigation.html.haml' unless RadConfig.shared_database?
        remove_file 'config/initializers/new_framework_defaults_7_0.rb'
        remove_file 'app/models/application_record.rb'
        remove_file '.hound.yml'
        remove_file '.github/pull_request_template.md'
        remove_file 'app/controllers/application_controller.rb'

        unless RadConfig.legacy_assets?
          remove_dir 'public/packs'
          remove_dir 'public/packs-test'
        end

        fix_namespacing
        add_crawling_config
        install_procfile
        standardize_date_methods
        install_database_yml
        install_github_workflow
        update_seeder_method
        replace_webdrivers_gem_with_selenium
        add_rad_config_setting 'last_first_user', 'false'
        add_rad_config_setting 'timezone_detection', 'true'
        add_rad_config_setting 'portal', 'false'
        add_rad_config_setting 'validate_user_domains', 'true'
        add_rad_config_setting 'show_sign_in_marketing', 'false'
        remove_rad_factories
        remove_legacy_rails_config_setting
        update_credentials

        search_and_replace '= f.error_notification', '= rad_form_errors f'
        search_and_replace_file '3.2.2', '3.3.1', 'Gemfile'
        gsub_file 'Gemfile', /gem 'haml_lint', require: false/, "gem 'haml_lint', '0.55.0', require: false"
        gsub_file 'Gemfile', /https:\/\/github.com\/jayywolff\/twilio-verify-devise.git/, 'https://github.com/rad-stack/twilio-verify-devise.git'
        gsub_file 'Gemfile.lock', /https:\/\/github.com\/jayywolff\/twilio-verify-devise.git/, 'https://github.com/rad-stack/twilio-verify-devise.git'

        # misc
        merge_package_json unless RadConfig.legacy_assets?
        copy_custom_github_actions
        copy_custom_github_matrix
        copy_file '../../../../../.ruby-version', '.ruby-version'
        copy_file '../../../../../spec/dummy/Rakefile', 'Rakefile'

        copy_file '../../../../../spec/dummy/.nvmrc', '.nvmrc'
        copy_file '../../../../../spec/dummy/.active_record_doctor.rb', '.active_record_doctor.rb'
        copy_file '../gitignore.txt', '.gitignore'
        copy_file '../rails_helper.rb', 'spec/rails_helper.rb'
        copy_file '../../../../../spec/dummy/public/403.html', 'public/403.html'

        unless RadConfig.shared_database?
          copy_file '../../../../../spec/dummy/public/404.html', 'public/404.html'
        end

        migrate_webpacker_to_esbuild unless RadConfig.legacy_assets?

        migrate_to_tom_select

        # enable this as needed
        # migrate_to_bootstrap5

        copy_file '../../../../../spec/dummy/public/422.html', 'public/422.html'
        copy_file '../../../../../spec/dummy/public/500.html', 'public/500.html'
        copy_file '../../../../../spec/dummy/public/406-unsupported-browser.html',
                 'public/406-unsupported-browser.html'

        unless RadConfig.legacy_assets?
          copy_file '../../../../../spec/dummy/app/javascript/application.js',
                    'app/javascript/application.js'

          unless File.exist? 'app/javascript/controllers/app_specific/index.js'
            copy_file '../../../../../spec/dummy/app/javascript/controllers/app_specific/index.js',
                     'app/javascript/controllers/app_specific/index.js'
          end
          copy_file '../../../../../spec/dummy/app/javascript/controllers/index.js',
                   'app/javascript/controllers/index.js'
          copy_file '../../../../../spec/dummy/app/javascript/controllers/application.js',
                    'app/javascript/controllers/application.js'
        end

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
        gsub_file 'config/application.rb', 'Dummy', installed_app_name.split('_').map(&:capitalize).join

        copy_file '../../../../../spec/dummy/config/puma.rb', 'config/puma.rb'
        directory '../../../../../spec/dummy/config/environments/', 'config/environments/'

        template '../../../../../spec/dummy/config/initializers/devise.rb', 'config/initializers/devise.rb'

        template '../../../../../spec/dummy/config/initializers/devise_security.rb',
                 'config/initializers/devise_security.rb'

        unless RadConfig.legacy_assets?
          copy_file '../../../../../spec/dummy/config/initializers/assets.rb',
                    'config/initializers/assets.rb'
        end

        copy_file '../../../../../spec/dummy/config/initializers/simple_form.rb',
                  'config/initializers/simple_form.rb'

        copy_file '../../../../../spec/dummy/config/initializers/simple_form_bootstrap.rb',
                  'config/initializers/simple_form_bootstrap.rb'

        copy_file '../../../../../spec/dummy/config/initializers/simple_form_components.rb',
                  'config/initializers/simple_form_components.rb'

        # bin
        directory '../../../../../spec/dummy/bin/', 'bin/'
        gsub_file 'bin/setup', 'dummy', installed_app_name # TODO: Remove in Rails 8

        # locales
        copy_file '../../../../../spec/dummy/config/locales/devise.twilio_verify.en.yml',
                  'config/locales/devise.twilio_verify.en.yml'
        copy_file '../../../../../spec/dummy/config/locales/devise_invitable.en.yml',
                  'config/locales/devise_invitable.en.yml'
        copy_file '../../../../../spec/dummy/config/locales/devise.en.yml', 'config/locales/devise.en.yml'
        copy_file '../../../../../spec/dummy/config/locales/simple_form.en.yml',
                  'config/locales/simple_form.en.yml'

        copy_file '../../../../../spec/fixtures/test_photo.png', 'spec/fixtures/test_photo.png'

        # templates

        # active_record templates
        copy_file '../../../../../spec/dummy/lib/templates/active_record/model/model.rb.tt',
                  'lib/templates/active_record/model/model.rb.tt'
        remove_file 'lib/templates/active_record/model/model.rb' # Removed old non-TT file

        # haml templates
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
        copy_file '../../../../../spec/dummy/lib/templates/rails/scaffold_controller/controller.rb.tt',
                  'lib/templates/rails/scaffold_controller/controller.rb.tt'
        remove_file 'lib/templates/rails/scaffold_controller/controller.rb' # Removed old non-TT file

        # rspec templates
        copy_file '../../../../../spec/dummy/lib/templates/rspec/scaffold/request_spec.rb.tt',
                  'lib/templates/rspec/scaffold/request_spec.rb.tt'
        remove_file 'lib/templates/rspec/scaffold/request_spec.rb' # Removed old non-TT file

        copy_file '../../../../../spec/dummy/lib/templates/rspec/system/system_spec.rb.tt',
                  'lib/templates/rspec/system/system_spec.rb.tt'
        remove_file 'lib/templates/rspec/system/system_spec.rb' # Removed old non-TT file

        # pundit template
        copy_file '../../../../../spec/dummy/lib/templates/pundit/policy.rb.tt',
                  'lib/templates/pundit/policy.rb.tt'

        # factory bot
        copy_file '../../../../../spec/dummy/lib/templates/factory_bot/factory.rb.tt',
                  'lib/templates/factory_bot/factory.rb.tt'

        # search template
        copy_file '../../../../../spec/dummy/lib/templates/services/search.rb.tt',
                  'lib/templates/services/search.rb.tt'

        unless RadConfig.shared_database?
          create_file 'db/seeds.rb' do <<-'RUBY'
require 'factory_bot_rails'
require 'rad_rspec/rad_factories'

RadFactories.load!
Seeder.new.seed!
        RUBY
          end
        end

        inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do <<-'RUBY'

  mount RadCommon::Engine => '/rad_common'
  extend RadCommonRoutes

        RUBY
        end

        add_project_gems

        gsub_file 'Gemfile', "gem 'jsbundling-rails'\n", ''

        apply_migrations

        check_boolean_fields
      end

      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        if ActiveRecord.timestamped_migrations
          [Time.current.utc.strftime('%Y%m%d%H%M%S'), '%.14d' % next_migration_number].max
        else
          '%.3d' % next_migration_number
        end
      end

      protected

        def merge_package_json
          migrate_custom_dependencies_file # Temp: Migrate old custom_dependencies.json to new format

          dummy_file_path = '../../../../../spec/dummy/package.json'
          unless File.exist?('custom-dependencies.json')
            return copy_file dummy_file_path, 'package.json'
          end

          base_package_source = File.expand_path(find_in_source_paths(dummy_file_path))
          base_package = JSON.parse(File.read(base_package_source))
          custom_package = JSON.parse(File.read('custom-dependencies.json'))

          %w[dependencies devDependencies resolutions scripts].each do |key|
            next unless custom_package[key]

            base_package[key] ||= {}
            base_package[key].merge!(custom_package[key])
          end

          File.write('package.json', JSON.pretty_generate(base_package) + "\n")
        end

        def migrate_custom_dependencies_file
          return unless File.exist?('custom-dependencies.json')

          contents = JSON.parse(File.read('custom-dependencies.json'))
          if contents.is_a?(Hash) && (%w[dependencies devDependencies resolutions scripts] & contents.keys).none?
            new_contents = { 'dependencies' => contents }
            File.write('custom-dependencies.json', JSON.pretty_generate(new_contents) + "\n")
          end
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
          return if RadConfig.shared_database?

          filename = source.split('_').drop(1).join('_').gsub('.rb', '')

          if self.class.migration_exists?('db/migrate', filename)
            say_status('skipped', "Migration #{filename}.rb already exists")
          else
            migration_template "../../../../../spec/dummy/db/migrate/#{source}",
                               "db/migrate/#{filename}.rb"
          end
        end

        def search_and_replace(search, replace, js: false)
          search_and_replace_type search, replace, 'rb'
          search_and_replace_type search, replace, 'haml'
          search_and_replace_type search, replace, 'rake'
          return unless js

          search_and_replace_type search, replace, 'js'
        end

        def search_and_replace_type(search, replace, file_type)
          if ENV['CI']
            system "find . -type f -name \"*.#{file_type}\" -print0 | xargs -0 sed -i -e 's/#{search}/#{replace}/g'"
          else
            system "find . -type f -name \"*.#{file_type}\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          end
        end

        def search_and_replace_file(search, replace, file_name)
          if ENV['CI']
            system "find . -type f -name \"#{file_name}\" -print0 | xargs -0 sed -i -e 's/#{search}/#{replace}/g'"
          else
            system "find . -type f -name \"#{file_name}\" -print0 | xargs -0 sed -i '' -e 's/#{search}/#{replace}/g'"
          end
        end

        def fix_namespacing
          search_and_replace 'RadCommon::AppInfo', 'AppInfo'
          search_and_replace 'RadCommon::ApplicationHelper', 'RadHelper'

          search_and_replace 'RadCommon::ArrayFilter', 'RadSearch::ArrayFilter'
          search_and_replace 'RadCommon::BooleanFilter', 'RadSearch::BooleanFilter'
          search_and_replace 'RadCommon::DateFilter', 'RadSearch::DateFilter'
          search_and_replace 'RadCommon::EnumFilter', 'RadSearch::EnumFilter'
          search_and_replace 'RadCommon::EqualsFilter', 'RadSearch::EqualsFilter'
          search_and_replace 'RadCommon::FilterDefaulting', 'RadSearch::FilterDefaulting'
          search_and_replace 'RadCommon::Filtering', 'RadSearch::Filtering'
          search_and_replace 'RadCommon::HiddenFilter', 'RadSearch::HiddenFilter'
          search_and_replace 'RadCommon::LikeFilter', 'RadSearch::LikeFilter'
          search_and_replace 'RadCommon::PhoneNumberFilter', 'RadSearch::PhoneNumberFilter'
          search_and_replace 'RadCommon::Search', 'RadSearch::Search'
          search_and_replace 'RadCommon::SearchFilter', 'RadSearch::SearchFilter'
          search_and_replace 'RadCommon::Sorting', 'RadSearch::Sorting'
        end

        def add_crawling_config
          remove_file 'public/robots.txt'

          add_rad_config_setting 'crawlable_subdomains', '[]'
          add_rad_config_setting 'always_crawl', 'false'
          add_rad_config_setting 'allow_crawling', 'false'
        end

        def install_procfile
          setting_exists = rad_config_setting_exists?('procfile_override')
          add_rad_config_setting 'procfile_override', 'false'
          return if setting_exists && RadConfig.procfile_override?

          copy_file '../../../../../spec/dummy/Procfile', 'Procfile'
          copy_file '../../../../../spec/dummy/config/sidekiq.yml', 'config/sidekiq.yml'
        end

        def replace_webdrivers_gem_with_selenium
          gsub_file 'Gemfile', /\n\s*gem 'webdrivers'.*\n/, "\n"
          return if File.readlines('Gemfile').grep(/gem 'selenium-webdriver'/).any?

          gsub_file 'Gemfile', /\n\s*gem 'simplecov', require: false\n/, "\n  gem 'selenium-webdriver'\n  gem 'simplecov', require: false\n"
        end

        def remove_rad_factories
          Dir['spec/factories/rad_common/*.rb'].each do |factory_file|
            factory_name = File.basename(factory_file, '.rb')
            next if factory_name == 'clients'

            remove_file factory_file
          end

          if Dir.exist?('spec/factories/rad_common') && Dir.empty?('spec/factories/rad_common')
            Dir.rmdir('spec/factories/rad_common')
          end
        end

        def check_boolean_fields
          ActiveRecord::Base.connection.tables.each do |table|
            ActiveRecord::Base.connection.columns(table).each do |column|
              next unless column.type == :boolean && (column.null || column.default.blank?)

              raise "column #{table}.#{column.name}: null: #{column.null}, default: #{column.default}"
            end
          end
        end

        def add_rad_config_setting(setting_name, default_value)
          standard_config_end = /\n(  system_usage_models:)/
          new_config = "  #{setting_name}: #{default_value}\n\n"

          unless rad_config_setting_exists?(setting_name)
            gsub_file RAD_CONFIG_FILE, standard_config_end, "#{new_config}\\1"
          end
        end

        def rad_config_setting_exists?(setting_name)
          File.readlines(RAD_CONFIG_FILE).grep(/#{setting_name}:/).any?
        end

        def remove_legacy_rails_config_setting
          return unless rad_config_setting_exists?('legacy_rails_config')

          say_status :remove, 'legacy_rails_config from rad_common.yml'
          gsub_file RAD_CONFIG_FILE, /^\s*legacy_rails_config:\s*.*\n/, ''
        end

        def update_credentials
          # TODO: this entire method could use some refactor next time we need to udpate credentials
          return if ENV['CI']

          need_credentials_update = false

          %w[development test staging production].each do |environment|
            credentials_path = Rails.root.join("config/credentials/#{environment}.yml.enc")
            next unless File.exist?(credentials_path)

            key_path = Rails.root.join("config/credentials/#{environment}.key")
            decrypted_content = Rails.application.encrypted(credentials_path, key_path: key_path).read
            current_credentials = YAML.safe_load(decrypted_content) || {}
            next if current_credentials.key?('developer_domain')

            need_credentials_update = true
          end

          return unless need_credentials_update

          new_value = ask 'Enter the developer domain.'

          %w[development test staging production].each do |environment|
            credentials_path = Rails.root.join("config/credentials/#{environment}.yml.enc")
            next unless File.exist?(credentials_path)

            key_path = Rails.root.join("config/credentials/#{environment}.key")
            decrypted_content = Rails.application.encrypted(credentials_path, key_path: key_path).read
            current_credentials = YAML.safe_load(decrypted_content) || {}
            next if current_credentials.key?('developer_domain')

            new_line = "\n\ndeveloper_domain: #{new_value}"
            updated_content = decrypted_content.chomp + new_line + "\n"
            Rails.application.encrypted(credentials_path, key_path: key_path).write(updated_content)
          end

          %w[development test].each do |environment|
            credentials_path = Rails.root.join("config/credentials/#{environment}.yml.enc")
            next unless File.exist?(credentials_path)

            key_path = Rails.root.join("config/credentials/#{environment}.key")
            decrypted_content = Rails.application.encrypted(credentials_path, key_path: key_path).read
            current_credentials = YAML.safe_load(decrypted_content) || {}
            next if current_credentials['developer_domain'] == 'example.com'

            updated_content = decrypted_content.gsub("developer_domain: #{new_value}", 'developer_domain: example.com')
            Rails.application.encrypted(credentials_path, key_path: key_path).write(updated_content)
          end
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
          setting_exists = rad_config_setting_exists?('database_config_override')
          add_rad_config_setting 'database_config_override', 'false'
          return if setting_exists && RadConfig.database_config_override?

          copy_file '../../../../../spec/dummy/config/database.yml', 'config/temp_database.yml'
          gsub_file 'config/temp_database.yml', 'rad_common_', "#{installed_app_name}_"
          copy_file Rails.root.join('config/temp_database.yml'), 'config/database.yml'
          remove_file Rails.root.join('config/temp_database.yml')
        end

        def install_github_workflow
          if RadConfig.legacy_assets?
            copy_file '../rspec_tests_legacy.yml', '.github/workflows/rspec_tests.yml'
          else
            copy_file '../../../../../.github/workflows/rspec_tests.yml', '.github/workflows/rspec_tests.yml'
          end

          copy_file '../../../../../.github/workflows/rad_update_bot.yml', '.github/workflows/rad_update_bot.yml'
          copy_file '../../../../../.github/workflows/generate_coverage_report.yml',
                    '.github/workflows/generate_coverage_report.yml'
          remove_file '.github/workflows/rc_update.yml'
          gsub_file '.github/workflows/rspec_tests.yml', 'rad_common_test', "#{installed_app_name}_test"
          gsub_file '.github/workflows/generate_coverage_report.yml', 'rad_common_test', "#{installed_app_name}_test"

          if RadConfig.shared_database?
            gsub_file '.github/workflows/rad_update_bot.yml',
                      'rad_common_development',
                      'cannasaver_admin_development'
          else
            gsub_file '.github/workflows/rad_update_bot.yml',
                      'rad_common_development',
                      "#{installed_app_name}_development"
          end

          unless RadConfig.legacy_assets?
            gsub_file '.github/workflows/rspec_tests.yml', /^\s*working-directory: spec\/dummy\s*\n/, ''
            gsub_file '.github/workflows/rspec_tests.yml', 'spec/dummy/', ''
            gsub_file '.github/workflows/rspec_tests.yml',
                     "bundle exec parallel_rspec spec --exclude-pattern 'templates/rspec/*.*'",
                     'bin/rc_parallel_rspec'
          end
        end

        def migrate_webpacker_to_esbuild
          remove_dir 'config/webpack'
          remove_file 'config/webpacker.yml'
          remove_file 'bin/webpack'
          remove_file 'bin/webpack-dev-server'
          remove_file 'babel.config.js'
          remove_file '.browserslistrc'
          remove_file 'postcss.config.js'
          remove_file '.dockerignore'
          remove_file 'Dockerfile'

          copy_file '../../../../../spec/dummy/esbuild.config.js', 'esbuild.config.js'
          copy_file '../../../../../spec/dummy/Procfile.dev', 'Procfile.dev'

          if Dir.exist?('app/javascript/packs')
            remove_file 'app/javascript/packs/rad_mailer.js'

            Dir['app/javascript/packs/*'].each do |file|
              copy_file Rails.root.join(file), "app/javascript/#{File.basename(file)}"
            end

            remove_dir 'app/javascript/packs'
          end

          if Dir.exist?('app/javascript/images')
            Dir['app/javascript/images/*'].each do |file|
              copy_file Rails.root.join(file), "app/assets/images/#{File.basename(file)}"
            end

            remove_dir 'app/javascript/images'
          end

          search_and_replace 'image_pack_tag', 'image_tag'
          search_and_replace 'javascript_pack_tag', 'javascript_include_tag'
          search_and_replace 'stylesheet_pack_tag', 'stylesheet_link_tag'
          search_and_replace 'favicon_pack_tag', 'favicon_link_tag'

          copy_file '../../../../../spec/dummy/app/assets/scss/application.scss',
                    'app/assets/scss/application.scss'
          copy_file '../../../../../spec/dummy/app/assets/scss/rad_mailer.scss',
                    'app/assets/scss/rad_mailer.scss'
          unless File.exist? 'app/assets/scss/app_specific/main.scss'
            create_file 'app/assets/scss/app_specific/main.scss'
          end

          if Dir.exist?('app/javascript/css')
            Dir['app/javascript/css/*'].each do |file|
              copy_file Rails.root.join(file), "app/assets/scss/#{File.basename(file)}"
            end

            remove_dir 'app/javascript/css'
          end
        end

        def migrate_to_tom_select
          return if RadConfig.legacy_assets?

          search_and_replace 'bootstrap_select', 'tom_select'
          search_and_replace 'rad-chosen', 'selectpicker'
        end

        def add_project_gems
          inject_into_file 'Gemfile', after: "gem 'rubocop', require: false\n" do <<-'RUBY'
gem 'rubocop-capybara'
          RUBY
          end
          inject_into_file 'Gemfile', after: "gem 'better_errors'\n" do <<-'RUBY'
  gem 'tty-prompt'
        RUBY
          end

          unless RadConfig.legacy_assets?
            inject_into_file 'Gemfile', after: "gem 'bootsnap', require: false\n" do <<-'RUBY'
gem 'propshaft'
            RUBY
            end
          end
        end

        def migrate_to_bootstrap5
          search_and_replace 'ml-', 'ms-'
          search_and_replace 'mr-', 'me-'
          search_and_replace 'pl-', 'ps-'
          search_and_replace 'pr-', 'pe-'

          search_and_replace 'float-left', 'float-start'
          search_and_replace 'text-left', 'text-start'
          search_and_replace 'text-sm-left', 'text-sm-start'
          search_and_replace 'text-md-left', 'text-md-start'
          search_and_replace 'text-lg-left', 'text-lg-start'

          search_and_replace 'float-right', 'float-end'
          search_and_replace 'text-right', 'text-end'
          search_and_replace 'text-sm-right', 'text-sm-end'
          search_and_replace 'text-md-right', 'text-md-end'
          search_and_replace 'text-lg-right', 'text-lg-end'
          search_and_replace 'data-toggle', 'data-bs-toggle'

          # data: { toggle: 'str', target:
          gsub_from_file_content(search_pattern: /data: \{ toggle: '([^']*)',(\s*)target:/,
                               replacement_string: "data: { 'bs-toggle': '\\1',\\2'bs-target':")
          # data: { placement: 'str', toggle:
          gsub_from_file_content(search_pattern: /data: \{ placement: '([^']*)',(\s*)toggle:/,
                                 replacement_string: "data: { 'bs-placement': '\\1',\\2'bs-toggle':")
          # data: { toggle: 'str', placement: }
          gsub_from_file_content(search_pattern: /data: \{ toggle: '([^']*)',(\s*)placement:/,
                                 replacement_string: "data: { 'bs-toggle': '\\1',\\2'bs-placement':")
          # data: { toggle:
          gsub_from_file_content(search_pattern: /data: \{ toggle:/,
                                 replacement_string: "data: { 'bs-toggle':")
          # data: { target:
          gsub_from_file_content(search_pattern: /data: \{ target:/,
                                 replacement_string: "data: { 'bs-target':")

          search_and_replace 'data-placement', 'data-bs-placement'
          search_and_replace 'data-dismiss', 'data-bs-dismiss'
          search_and_replace 'data-target', 'data-bs-target'

          search_and_replace 'form-group', 'mb-3'
          search_and_replace 'form-inline', 'd-flex align-items-center'
          search_and_replace 'badge-pill', 'rounded-pill'
          search_and_replace 'badge-primary', 'bg-primary'
          search_and_replace 'badge-warning', 'bg-warning'
          search_and_replace 'badge-danger', 'bg-danger'
          search_and_replace 'badge-info', 'bg-info'
          search_and_replace 'badge-success', 'bg-success'
          search_and_replace 'badge-secondary', 'bg-secondary'

          search_and_replace 'dropdown-menu-right', 'dropdown-menu-end'
          search_and_replace 'dropdown-menu-left', 'dropdown-menu-start'
          search_and_replace 'input-group-prepend', 'input-group-text'
          search_and_replace 'input-group-append', 'input-group-text'

          search_and_replace 'twitter-bootstrap-4', 'bootstrap-5'
          search_and_replace 'badge alert-', 'badge bg-opacity-75 bg-'
          search_and_replace 'badge.alert-', 'badge.bg-opacity-75.bg-'
        end

        def gsub_from_file_content(search_pattern:, replacement_string:)
          project_root = Dir.pwd
          matching_files = []

          Find.find(project_root) do |path|
            next if File.directory?(path)
            next unless path.include?('/app/')
            next if path.include?('/assets/')
            next if path.downcase.include?('.ds_store')

            begin
              content = File.read(path)
              if content.match?(search_pattern)
                matching_files << path
              end
            rescue => e
              puts "Error reading #{path}: #{e.message}"
            end
          end

          matching_files.each do |file_path|
            gsub_file(file_path, search_pattern, replacement_string)
          end
        end

        def apply_migrations
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
          apply_migration '20240209114718_make_audits_created_at_non_nullable.rb'
          apply_migration '20240209141219_missing_fks.rb'
          apply_migration '20240222093233_active_record_doctor_issues.rb'
          apply_migration '20240313112119_more_active_record_doctor_issues.rb'
          apply_migration '20240412165055_rename_twilio_logs.rb'
          apply_migration '20240412175512_create_contact_log_recipients.rb'
          apply_migration '20240418101832_remove_contact_log_attachments.rb'
          apply_migration '20240420112825_contact_log_content.rb'
          apply_migration '20240423100042_rename_contact_fields.rb'
          apply_migration '20240602130347_contact_log_sendgrid_stuff.rb'
          apply_migration '20240604194517_more_sendgrid_stuff.rb'
          apply_migration '20240611203430_fix_boolean_nulls_defaults.rb'
          apply_migration '20240629114200_fix_contact_log_sms_status.rb'
          apply_migration '20240705173121_more_contact_log_fixes.rb'
          apply_migration '20240709115421_notify_tool_actions.rb'
          apply_migration '20240710175508_fix_contact_to_users.rb'
          apply_migration '20240803114036_bcc_notify_recipient.rb'
          apply_migration '20240912133320_persist_sms_false_positive.rb'
          apply_migration '20240911184745_fix_last_activity.rb'
          apply_migration '20250227191231_add_detected_timezone_to_user.rb'
          apply_migration '20250402083306_add_sms_message_id_index.rb'
          apply_migration '20250425120906_fix_some_renamed_audit_models.rb'
          apply_migration '20250512115245_two_factor_auth_updates.rb'
          apply_migration '20250622203947_user_js_timezone.rb'
          apply_migration '20250914154915_fix_developer_notifications.rb'
          apply_migration '20251003162830_add_fax_contact_log_fields.rb'
          apply_migration '20251007153435_move_fax_error_message.rb'
          apply_migration '20250418211716_add_created_at_index_to_system_usages.rb'
          apply_migration '20251017110121_rename_direction_to_contact_direction.rb'
        end

        def installed_app_name
          ::Rails.application.class.module_parent.to_s.underscore
        end

        RAD_CONFIG_FILE = 'config/rad_common.yml'.freeze
    end
  end
end
