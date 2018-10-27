source 'https://rubygems.org'

# Declare your gem's dependencies in rad_common.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'schema_validations',  git: 'https://github.com/SynergyDataSystems/schema_validations'
gem 'schema_plus_columns', git: 'https://github.com/SynergyDataSystems/schema_plus_columns'
gem 'schema_plus_core', git: 'https://github.com/SynergyDataSystems/schema_plus_core'
gem 'schema_plus_indexes', git: 'https://github.com/SynergyDataSystems/schema_plus_indexes'

group :test do
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'rails-controller-testing', '1.0.2'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'pry'
end
