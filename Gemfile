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

gem 'schema_validations',  git: 'https://github.com/SchemaPlus/schema_validations.git'

group :test do
  gem 'capybara-selenium'
  gem 'chromedriver-helper'
  gem 'launchy'
  gem 'rails-controller-testing', '1.0.2'
  gem 'simplecov', require: false
  gem 'selenium-webdriver'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'pry'
end
