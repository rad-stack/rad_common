# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter 'lib/templates'
    add_filter 'install_generator.rb'

    add_group 'Services', 'app/services'
    add_group 'Policies', 'app/policies'

    groups.delete('Libraries')
    groups.delete('Channels')
  end
end

require File.expand_path('dummy/config/environment.rb', __dir__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'capybara/rails'
require 'selenium/webdriver'
require 'pundit/rspec'
require 'factory_bot_rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
SpecSupport.load_dependencies

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  include TestHelpers

  config.include FactoryBot::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless=new')
    options.add_argument('--window-size=1400,900')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-gpu')

    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   options: options
  end

  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--window-size=1400,900')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-gpu')

    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   options: options
  end

  chrome_driver = ENV['show_browser'] ? :chrome : :headless_chrome
  Capybara.javascript_driver = chrome_driver

  config.before do
    # TODO: workaround for this issue:
    # https://github.com/rails/rails/issues/37270
    (ActiveJob::Base.descendants << ActiveJob::Base).each(&:disable_test_adapter)
    # TODO: end of workaround

    Timecop.safe_mode = true

    SpecSupport.before_all { self }
  end

  SpecSupport.hooks(config, chrome_driver)

  config.filter_run_excluding(twilio_verify_specs: true) unless RadConfig.twilio_verify_enabled?
  config.filter_run_excluding(impersonate_specs: true) unless RadConfig.impersonate?
  config.filter_run_excluding(invite_specs: true) if RadConfig.disable_invite?
  config.filter_run_excluding(sign_up_specs: true) if RadConfig.disable_sign_up?
  config.filter_run_excluding(external_user_specs: true) unless RadConfig.external_users?
  config.filter_run_excluding(user_client_specs: true) unless RadConfig.user_clients?
  config.filter_run_excluding(devise_paranoid_specs: true) unless Devise.paranoid
  config.filter_run_excluding(smarty_specs: true) unless RadConfig.smarty_enabled?
  config.filter_run_excluding(user_confirmable_specs: true) unless RadConfig.user_confirmable?
  config.filter_run_excluding(user_expirable_specs: true) unless RadConfig.user_expirable?
  config.filter_run_excluding(gha_specs_only: true) unless ENV['CI']

  include Warden::Test::Helpers
  config.include Capybara::DSL
end
