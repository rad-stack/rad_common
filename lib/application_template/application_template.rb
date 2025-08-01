def copy_github_file(source, destination)
  get "https://raw.githubusercontent.com/rad-stack/rad_common/refs/heads/rad-10334-app-templates/#{source}", destination
end

def fix_routes
  remove_file 'config/routes.rb'

  create_file 'config/routes.rb', <<~RUBY
    Rails.application.routes.draw do
      mount RadCommon::Engine => '/rad_common'
      extend RadCommonRoutes
    end
  RUBY
end

# TODO: are these comments still relevant?
# Skip importmap installation
# skip_option :javascript

remove_file 'Gemfile'
run 'touch Gemfile'
add_source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'propshaft'
gem 'rad_common', git: 'https://github.com/rad-stack/rad_common.git', branch: 'main'

gem 'devise-twilio-verify', git: 'https://github.com/rad-stack/twilio-verify-devise.git',
                            branch: 'authy-to-twilio-verify'

gem_group :development do
  gem 'active_record_doctor'
  gem 'better_errors'
  gem 'tty-prompt'
  gem 'binding_of_caller'
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
end

after_bundle do
  copy_github_file 'spec/dummy/config/rad_common.yml', 'config/rad_common.yml'

  copy_file '~/.rad_common_setup/test.key', 'config/credentials/test.key'
  copy_file '~/.rad_common_setup/development.key', 'config/credentials/development.key'

  copy_github_file 'lib/application_template/credentials/development.yml.enc',
                   'config/credentials/development.yml.enc'

  copy_github_file 'lib/application_template/credentials/test.yml.enc',
                   'config/credentials/test.yml.enc'

  generate 'devise:install'
  generate 'devise', 'User'

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
  generate 'audited:install'

  rails_command 'active_storage:install'

  rails_command 'db:create'

  run 'bundle binstubs rad_common --force'

  generate 'rad_common:install', '--skip'

  create_file 'app/services/seeder.rb', <<~RUBY
    class Seeder < RadSeeder
      def seed
        # Add initial data here
      end
    end
  RUBY

  create_file 'app/javascript/app_specific.js', ''

  create_file 'app/services/nav.rb', <<~RUBY
    class Nav < RadNav::Nav
      def top_nav_items
        [top_nav_item('Home', '/')]
      end
    end
  RUBY

  # Copy assets
  # copy_github_file 'spec/dummy/app/assets/images/app_logo.png?raw=true',
  #                  'app/assets/images/app_logo.png'
  # copy_github_file 'spec/dummy/app/assets/images/favicon.ico.png?raw=true',
  #                  'app/assets/images/favicon.ico'

  # remove_file 'app/views/layouts/application.html.erb'

  remove_file 'app/models/user.rb'

  create_file 'app/models/user.rb', <<~RUBY.strip
    class User < ApplicationRecord
      include RadDeviseHigh
      include RadUser
    end
  RUBY

  create_file 'app/controllers/application_controller.rb', <<~RUBY.strip
    class ApplicationController < ActionController::Base
      include RadController

      before_action :authenticate_user!

      protect_from_forgery prepend: true, with: :exception
    end
  RUBY

  create_file 'app/policies/application_policy.rb', <<~RUBY
    class ApplicationPolicy < RadPolicy
    end
  RUBY

  fix_routes

  generate 'rad_common:install', '--force'

  fix_routes

  run 'bin/migrate_reset'

  run 'yarn install'
  run 'yarn build'

  rails_command 'db:seed'

  say 'Rails application with rad_common setup complete!', :green
end
