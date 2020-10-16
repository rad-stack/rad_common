# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'lib/templates'
  add_filter 'install_generator.rb'
end

require 'spec_helper'
require File.expand_path('dummy/config/environment.rb', __dir__)
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'capybara/rails'
require 'factory_bot_rails'
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

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'vcr')
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'chromedriver.storage.googleapis.com'

  c.filter_sensitive_data('<TEST_MOBILE_PHONE>') { ENV.fetch('TEST_MOBILE_PHONE') }
  c.filter_sensitive_data('<TEST_PHONE_NUMBER>') { ENV.fetch('TEST_PHONE_NUMBER') }

  c.filter_sensitive_data('<TEST_MOBILE_PHONE_STRIPPED>') do
    ENV.fetch('TEST_MOBILE_PHONE').gsub('(', '').gsub(')', '').gsub(' ', '').gsub('-', '')
  end

  c.filter_sensitive_data('<TEST_PHONE_NUMBER_STRIPPED>') do
    ENV.fetch('TEST_PHONE_NUMBER').gsub('(', '').gsub(')', '').gsub(' ', '').gsub('-', '')
  end

  c.filter_sensitive_data('<AUTHY_API_KEY>') { ENV.fetch('AUTHY_API_KEY') }
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(%r{[^\w/]+}, '_')
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
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
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

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

    allow(RadicalTwilio).to receive(:twilio_enabled?).and_return(false)

    allow(Company).to receive(:main).and_return(create(:company))

    allow(UserStatus).to receive(:default_pending_status).and_return(create(:user_status, :pending, name: 'Pending'))
    allow(UserStatus).to receive(:default_active_status).and_return(create(:user_status, :active, name: 'Active'))
    allow(UserStatus).to receive(:default_inactive_status).and_return(create(:user_status, :inactive, name: 'Inactive'))

    allow_any_instance_of(Division).to receive(:notify_owner).and_return(nil)
  end

  config.after(:each, type: :system, js: true) do
    errors = page.driver.browser.manage.logs.get(:browser).reject { |e| e.level == 'WARNING' }
    expect(errors.presence).to be_nil, errors.map(&:message).join(', ')
  end

  config.after do
    Warden.test_reset!
  end

  include Warden::Test::Helpers
  config.include Capybara::DSL

  config.before(:example, type: :system) do
    driven_by :rack_test
  end

  config.before(:example, type: :system, js: true) do
    driven_by chrome_driver
  end
end
