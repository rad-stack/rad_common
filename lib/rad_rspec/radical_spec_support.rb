class RadicalSpecSupport
  def self.before_all
    rspec = yield
    rspec.allow_any_instance_of(RadicalTwilio).to rspec.receive(:twilio_enabled?).and_return false

    rspec.allow(Company).to rspec.receive(:main).and_return(Company.main || rspec.create(:company))

    pending_status = UserStatus.default_pending_status

    rspec.allow(UserStatus).to rspec.receive(:default_pending_status).and_return pending_status || rspec.create(
      :user_status, :pending, name: 'Pending'
    )

    active_status = UserStatus.default_active_status

    rspec.allow(UserStatus).to rspec.receive(:default_active_status).and_return active_status || rspec.create(
      :user_status, :active, name: 'Active'
    )

    inactive_status = UserStatus.default_inactive_status

    rspec.allow(UserStatus).to rspec.receive(:default_inactive_status).and_return inactive_status || rspec.create(
      :user_status, :inactive, name: 'Inactive'
    )
  end

  def self.load_dependencies
    require_relative 'test_helpers'
    load_vcr
  end

  def self.load_vcr
    app_path = Rails.root.join('spec/support/vcr.rb').to_s
    return require(app_path) if File.exist?(app_path)

    require_relative 'vcr'
  end

  def self.hooks(config, driver)
    config.after(:each, type: :system, js: true) do
      errors = page.driver.browser.manage.logs.get(:browser)
      errors = errors.reject { |error| error.level == 'WARNING' }
      expect(errors.presence).to be_nil, errors.map(&:message).join(', ')
    end

    config.before(:example, type: :system) do
      driven_by :rack_test
    end

    config.before(:each, type: :system, js: true) do
      driven_by driver
    end

    config.after do
      Warden.test_reset!
    end
  end
end
