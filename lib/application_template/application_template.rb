DEFAULT_RAD_COMMON_BRANCH = 'rad-10334-app-templates'.freeze # TODO: switch this to use main branch when merged
DEFAULT_RAD_COMMON_DIRECTORY = '~/Projects/rad_common'.freeze

def quiet_mode?
  ARGV.include?('--quiet') || ARGV.include?('-q')
end

def quiet_flag
  quiet_mode? ? '--quiet' : nil
end

def copy_github_file(source, destination)
  get "https://raw.githubusercontent.com/rad-stack/rad_common/refs/heads/#{@rad_common_branch}/#{source}", destination
end

def copy_image_file(filename)
  get "https://github.com/rad-stack/rad_common/raw/refs/heads/#{@rad_common_branch}/spec/dummy/app/assets/images/#{filename}",
      "app/assets/images/#{filename}"
end

def fix_routes
  remove_file 'config/routes.rb'

  create_file 'config/routes.rb', <<~RUBY
    Rails.application.routes.draw do
      mount RadCommon::Engine => '/rad_common'
      extend RadCommonRoutes

      # add your routes here
    end
  RUBY
end

def rails_secret
  `rails secret`.strip
end

def rad_common_credential(name)
  inside("#{@rad_common_directory}/spec/dummy") do
    `RAILS_ENV=test bundle exec rails runner "puts Rails.application.credentials.#{name}"`.strip
  end
end

def fix_gemfile
  gsub_file 'Gemfile', /"/, "'"

  add_git_source_and_ruby_version

  gsub_file 'Gemfile', /gem 'bootsnap'/, <<~GEMS.chomp
    # standard gems
    gem 'bootsnap'
  GEMS

  gsub_file 'Gemfile', /gem 'image_processing', '~> 1\.14'\n/, ''
end

def add_git_source_and_ruby_version
  insert_into_file 'Gemfile', after: /source 'https:\/\/rubygems\.org'\n/ do
    <<~CONTENT
      git_source(:github) { |repo| "https://github.com/\#{repo}.git" }

      ruby '3.3.1'

    CONTENT
  end
end

def s3_bucket_name
  app_name.gsub('_', '-')
end

def development_credentials
  <<~YAML
    secret_key_base: #{rails_secret}

    admin_email: System Admin <admin@example.com>
    from_email: System Admin <admin@example.com>

    s3_region: n/a
    s3_access_key_id: n/a
    s3_secret_access_key: n/a
    s3_bucket: n/a

    hash_key: foobar
    hash_alphabet: abcdefghijklmnopqrstuvwxyz

    seeded_users:
      -
        factory: admin
        email: admin@example.com
        first_name: Test
        last_name: Admin
        security_role: Admin
      -
        factory: user
        email: user@example.com
        first_name: Test
        last_name: User
        security_role: User
  YAML
end

def test_credentials
  <<~YAML
    admin_email: System Admin <admin@example.com>
    from_email: System Admin <admin@example.com>

    s3_region: n/a
    s3_access_key_id: n/a
    s3_secret_access_key: n/a
    s3_bucket: n/a

    twilio_phone_number: #{rad_common_credential('twilio_phone_number')}
    twilio_account_sid: #{rad_common_credential('twilio_account_sid')}
    twilio_auth_token: #{rad_common_credential('twilio_auth_token')}

    test_mobile_phone: #{rad_common_credential('test_mobile_phone')}

    seeded_users:
      -
        factory: admin
        email: admin@example.com
        first_name: Test
        last_name: Admin
        security_role: Admin
      -
        factory: user
        email: user@example.com
        first_name: Test
        last_name: User
        security_role: User
  YAML
end

def production_credentials
  <<~YAML
    admin_email: insert-value-here
    from_email: insert-value-here

    sendgrid_api_key: insert-value-here

    smtp_username: apikey
    smtp_password: insert-value-here

    s3_region: us-east-1
    s3_access_key_id: n/a
    s3_secret_access_key: n/a
    s3_bucket: #{s3_bucket_name}

    twilio_phone_number: insert-value-here
    twilio_account_sid: insert-value-here
    twilio_auth_token: insert-value-here
    twilio_verify_service_sid: insert-value-here

    smarty_auth_id: insert-value-here
    smarty_auth_token: insert-value-here

    test_phone_number: insert-value-here

    seeded_users:
      -
        factory: admin
        email: insert-value-here
        mobile_phone: insert-value-here
        first_name: insert-value-here
        last_name: insert-value-here
        security_role: Admin
      -
        factory: admin
        email: insert-value-here
        mobile_phone: insert-value-here
        first_name: insert-value-here
        last_name: insert-value-here
        security_role: Admin
      -
        factory: admin
        email: insert-value-here
        mobile_phone: insert-value-here
        first_name: insert-value-here
        last_name: insert-value-here
        security_role: Admin
  YAML
end

def create_credentials(environment)
  create_file 'temp_credentials.yml', send("#{environment}_credentials")
  run "EDITOR='cp temp_credentials.yml' rails credentials:edit --environment #{environment}"
  remove_file 'temp_credentials.yml'
end

@rad_common_branch = ask 'What branch of rad_common do you want to use? Hit return to accept the default.',
                         default: DEFAULT_RAD_COMMON_BRANCH

@rad_common_directory = ask 'Where is your local project directory for rad_common? Hit return to accept the default.',
                            default: DEFAULT_RAD_COMMON_DIRECTORY

remove_file 'Gemfile'
run 'touch Gemfile'
add_source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'propshaft'
gem 'rad_common', git: 'https://github.com/rad-stack/rad_common.git', branch: @rad_common_branch

gem 'devise-twilio-verify', git: 'https://github.com/rad-stack/twilio-verify-devise.git',
                            branch: 'authy-to-twilio-verify'

gem_group :development do
  gem 'active_record_doctor'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'haml_lint', '0.55.0', require: false
  gem 'rubocop', require: false
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
  gem 'tty-prompt'
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'parallel_tests'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

gem_group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'wkhtmltopdf-binary'
end

after_bundle do
  copy_github_file 'lib/application_template/rad_common.yml', 'config/rad_common.yml'

  copy_file "#{@rad_common_directory}/spec/dummy/config/credentials/test.key", 'config/credentials/test.key'

  copy_file "#{@rad_common_directory}/spec/dummy/config/credentials/development.key",
            'config/credentials/development.key'

  create_credentials 'development'
  create_credentials 'test'
  create_credentials 'production'

  remove_file '.rubocop.yml'

  create_file '.rubocop.yml', <<~YML
    inherit_gem:
      rad_common: .shared_rubocop.yml
  YML

  remove_file 'app/views/layouts/application.html.erb'
  remove_file 'app/views/layouts/mailer.html.erb'
  remove_file 'app/views/layouts/mailer.text.erb'
  remove_dir 'app/helpers'
  remove_dir 'app/jobs'

  generate 'simple_form:install', "--bootstrap #{quiet_flag}".strip
  generate 'devise:install', quiet_flag
  generate 'devise', "User #{quiet_flag}".strip
  generate 'devise_invitable:install', quiet_flag

  devise_migration = Dir['db/migrate/*devise_create_users.rb'].first

  if devise_migration
    uncomment_lines devise_migration, /sign_in_count/
    uncomment_lines devise_migration, /current_sign_in_at/
    uncomment_lines devise_migration, /last_sign_in_at/
    uncomment_lines devise_migration, /current_sign_in_ip/
    uncomment_lines devise_migration, /sign_in_count/
    uncomment_lines devise_migration, /last_sign_in_ip/
    uncomment_lines devise_migration, /confirmation_token/
    uncomment_lines devise_migration, /confirmed_at/
    uncomment_lines devise_migration, /confirmation_sent_at/
    uncomment_lines devise_migration, /unconfirmed_email/
    uncomment_lines devise_migration, /failed_attempts/
    uncomment_lines devise_migration, /unlock_token/
    uncomment_lines devise_migration, /locked_at/
  end

  generate 'audited:install', quiet_flag

  rails_command 'active_storage:install', abort_on_failure: true, capture: quiet_mode?
  rails_command 'action_text:install', abort_on_failure: true, capture: quiet_mode?

  remove_dir 'app/views/active_storage'
  remove_dir 'app/views/layouts'
  remove_dir 'spec/models'

  rails_command 'db:create', abort_on_failure: true, capture: quiet_mode?

  run 'bundle binstubs rad_common --force'

  generate 'rad_common:install', "--skip #{quiet_flag}".strip

  create_file 'app/services/seeder.rb', <<~RUBY
    class Seeder < RadSeeder
      def seed; end
    end
  RUBY

  create_file 'app/javascript/app_specific.js', ''
  remove_file 'config/locales/en.yml'
  create_file 'config/locales/en.yml', 'en:'

  create_file 'app/services/nav.rb', <<~RUBY
    class Nav < RadNav::Nav
      private

        def top_nav_items
          [admin_menu(true)]
        end
    end

  RUBY

  fix_routes
  remove_file 'spec/rails_helper.rb'
  generate 'rspec:install',
           "#{quiet_flag} create .rspec create spec create spec/spec_helper.rb create spec/rails_helper.rb".strip

  create_file 'spec/support/spec_support.rb', <<~RUBY
    require 'rad_rspec/rad_spec_support'
    class SpecSupport < RadSpecSupport
    end

  RUBY

  copy_image_file 'app_logo.png'
  copy_image_file 'favicon.ico'

  remove_file 'app/models/user.rb'
  remove_file 'spec/models/user_spec.rb'

  create_file 'app/models/user.rb', <<~RUBY.strip
    class User < ApplicationRecord
      include RadDeviseMedium
      include RadUser

      audited except: USER_AUDIT_COLUMNS_DISABLED
    end

  RUBY

  create_file 'app/controllers/application_controller.rb', <<~RUBY.strip
    class ApplicationController < ActionController::Base
      include RadController

      before_action :authenticate_user!

      protect_from_forgery prepend: true, with: :exception
    end
  RUBY

  remove_file 'README.md'

  create_file 'README.md', <<~RUBY.strip
    # #{app_name.titleize}

  RUBY

  gsub_file 'config/rad_common.yml', 'app_name: New Rails App', "app_name: #{app_name.titleize}"
  fix_routes
  generate 'rad_common:install', "--force #{quiet_flag}".strip
  fix_routes

  fix_gemfile

  remove_file '.github/workflows/ci.yml'
  remove_file '.github/dependabot.yml'
  remove_dir 'app/assets/config'
  remove_dir 'app/assets/stylesheets'
  remove_file 'app/assets/images/.keep'
  remove_dir 'app/channels'
  remove_file 'app/helpers/application_helper.rb'
  remove_file 'app/jobs/application_job.rb'
  remove_dir 'app/mailers'
  remove_dir 'app/views/pwa'
  remove_file 'bin/brakeman'
  remove_file 'bin/docker-entrypoint'
  remove_file 'config/cable.yml'
  remove_file 'config/credentials.yml.enc'
  remove_file 'config/master.key'
  remove_dir 'lib/assets'
  remove_file 'public/apple-touch-icon.png'
  remove_file 'public/icon.png'
  remove_file 'public/icon.svg'
  remove_file '.gitattributes'
  remove_dir 'vendor'

  rails_command 'db:drop', abort_on_failure: true, capture: quiet_mode?
  rails_command 'db:create', abort_on_failure: true, capture: quiet_mode?
  rails_command 'db:migrate', abort_on_failure: true, capture: quiet_mode?

  run 'yarn install'
  run 'yarn build'

  rails_command 'db:seed', abort_on_failure: true, capture: quiet_mode?

  run 'chmod u+x bin/dev'
end
