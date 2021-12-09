# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'lib/templates'
end

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'capybara/rails'
require 'selenium/webdriver'
require 'pundit/rspec'

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
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless disable-popup-blocking disable-gpu window-size=1400,900], w3c: false }
    )

    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   desired_capabilities: capabilities
  end

  Capybara.register_driver :chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[disable-popup-blocking disable-gpu window-size=1400,900], w3c: false }
    )

    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   desired_capabilities: capabilities
  end

  chrome_driver = ENV['show_browser'] ? :chrome : :headless_chrome
  Capybara.javascript_driver = chrome_driver

  config.before do
    # TODO: workaround for this issue:
    # https://github.com/rails/rails/issues/37270
    (ActiveJob::Base.descendants << ActiveJob::Base).each(&:disable_test_adapter)
    # TODO: end of workaround

    Timecop.safe_mode = true

    allow_any_instance_of(RadicalTwilio).to receive(:twilio_enabled?).and_return false

    allow(Company).to receive(:main).and_return(create(:company))

    allow(UserStatus).to receive(:default_pending_status).and_return(create(:user_status, :pending, name: 'Pending'))
    allow(UserStatus).to receive(:default_active_status).and_return(create(:user_status, :active, name: 'Active'))
    allow(UserStatus).to receive(:default_inactive_status).and_return(create(:user_status, :inactive, name: 'Inactive'))
  end

  config.filter_run_excluding(authy_specs: true) unless RadicalConfig.authy_enabled?
  config.filter_run_excluding(impersonate_specs: true) unless Rails.configuration.rad_common.impersonate
  config.filter_run_excluding(invite_specs: true) if Rails.configuration.rad_common.disable_invite

  config.after(:each, type: :system, js: true) do
    errors = page.driver.browser.manage.logs.get(:browser)
    errors = errors.reject { |error| error.level == 'WARNING' }
    expect(errors.presence).to be_nil, errors.map(&:message).join(', ')
  end

  config.before(:example, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by chrome_driver
  end

  config.after do
    Warden.test_reset!
  end

  include Warden::Test::Helpers
  config.include Capybara::DSL
end
