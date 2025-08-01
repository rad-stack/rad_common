# Rails Application Template for rad_common setup

# Skip importmap installation
# skip_option :javascript

# Ensure we're using the correct Ruby version
# create_file '.ruby-version', '3.3.1'

# Add gems to Gemfile
gem_group :default do
  gem 'bootsnap', require: false
  gem 'propshaft'
  gem 'rad_common', git: 'https://github.com/rad-stack/rad_common.git', branch: 'main'

  # TODO: remove this when possible
  gem 'devise-twilio-verify', git: 'https://github.com/rad-stack/twilio-verify-devise.git',
      branch: 'authy-to-twilio-verify'

  # project specific gems
  gem 'acts-as-taggable-on'
  gem 'bootstrap-select-rails'
  gem 'faraday-retry' # https://app.radstack.com/tasks/20
  gem 'haml_lint', '0.55.0'
  gem 'holidays'
  gem 'jbuilder'
  gem 'octokit'
  gem 'omniauth-github'
  gem 'omniauth-rails_csrf_protection'
  gem 'pathspec'
  gem 'quickbooks-ruby'
  gem 'recaptcha'
  gem 'rexml'
  gem 'rubocop'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'sidekiq-limit_fetch'
  gem 'stripe', '~> 5.17.0'
end

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

# Run bundle install
after_bundle do
  # Copy rad_common config
  get 'https://raw.githubusercontent.com/rad-stack/rad_common/refs/heads/rad-10334-app-templates/spec/dummy/config/rad_common.yml', 'config/rad_common.yml'

  # Copy base credentials
  copy_file '~/.rad_common_setup/test.key', 'config/credentials/test.key'
  copy_file '~/.rad_common_setup/development.key', 'config/credentials/development.key'
  get 'https://raw.githubusercontent.com/rad-stack/rad_common/refs/heads/rad-10334-app-templates/lib/application_template/credentials/development.yml.enc', 'config/credentials/development.yml.enc'
  get 'https://raw.githubusercontent.com/rad-stack/rad_common/refs/heads/rad-10334-app-templates/lib/application_template/credentials/test.yml.enc', 'config/credentials/test.yml.enc'

  # Generate devise
  generate 'devise:install'
  generate 'devise', 'User'

  # Uncomment all lines in the devise User migration
  devise_migration = Dir['db/migrate/*devise_create_users.rb'].first
  if devise_migration
    uncomment_lines devise_migration, /^\s*#\s*t\./
    uncomment_lines devise_migration, /^\s*#\s*add_index/
  end

  # Generate audited
  generate 'audited:install'

  # Install Active Storage
  rails_command 'active_storage:install'

  # Run database setup
  rails_command 'db:create'
  rails_command 'db:migrate'

  # Set up binstubs
  run 'bundle binstubs rad_common --force'

  # Generate rad_common install
  generate 'rad_common:install'

  # Create seeder service
  create_file 'app/services/seeder.rb', <<~RUBY
    class Seeder < RadSeeder
      def seed
        # Add initial data here
      end
    end
  RUBY

  # Create blank app_specific.js
  create_file 'app/javascript/app_specific.js', ''

  # Create nav service
  create_file 'app/services/nav.rb', <<~RUBY
    class Nav < RadNav::Nav
      def top_nav_items
        [top_nav_item('Home', '/')]
      end
    end
  RUBY

  # Copy assets
  get 'https://github.com/rad-stack/rad_common/blob/rad-10334-app-templates/spec/dummy/app/assets/images/app_logo.png?raw=true', 'app/assets/images/app_logo.png'
  get 'https://github.com/rad-stack/rad_common/blob/rad-10334-app-templates/spec/dummy/app/assets/images/favicon.ico.png?raw=true', 'app/assets/images/favicon.ico'

  # Remove default layout (we'll use rad_common's)
  remove_file 'app/views/layouts/application.html.erb'

  # Update User model
  gsub_file 'app/models/user.rb', /devise :.*/, ''
  gsub_file 'app/models/user.rb', /class User < ApplicationRecord/, <<~RUBY.strip
    class User < ApplicationRecord
      include RadDeviseHigh
      include RadUser
  RUBY

  # Update ApplicationController
  gsub_file 'app/controllers/application_controller.rb', /class ApplicationController < ActionController::Base/, <<~RUBY.strip
    class ApplicationController < ActionController::Base
      include RadController
  RUBY

  # Create ApplicationPolicy
  create_file 'app/policies/application_policy.rb', <<~RUBY
    class ApplicationPolicy < RadPolicy
    end
  RUBY

  # Install yarn dependencies and build
  run 'yarn install'
  run 'yarn build'

  # Seed the database
  rails_command 'db:seed'

  say 'Rails application with rad_common setup complete!', :green
end
