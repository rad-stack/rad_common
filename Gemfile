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

gem 'devise-twilio-verify', git: 'https://github.com/injuryscripts/twilio-verify-devise.git'

group :test do
  gem 'capybara-selenium'
  gem 'parallel_tests'
  gem 'selenium-webdriver', '4.8.0'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webdrivers'
end

group :development, :test do
  gem 'bootsnap', require: false
  gem 'pry'
  gem 'yard'
end
