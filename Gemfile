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

# TODO: move these to gemspec when the updates are available in rubygems
gem 'rails-observers', git: 'https://github.com/rails/rails-observers.git'
gem 'schema_plus_foreign_keys', git: 'https://github.com/SchemaPlus/schema_plus_foreign_keys.git', branch: 'AR51-support'

group :test do
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'rails-controller-testing', '1.0.2'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
end
