class RadicalSpecSupport
  def self.before_all
    rspec = yield
    rspec.allow_any_instance_of(RadicalTwilio).to rspec.receive(:twilio_enabled?).and_return false

    rspec.allow(Company).to rspec.receive(:main).and_return(rspec.create(:company))

    rspec.allow(UserStatus).to rspec.receive(:default_pending_status)
                                    .and_return(rspec.create(:user_status, :pending, name: 'Pending'))
    rspec.allow(UserStatus).to rspec.receive(:default_active_status)
                                    .and_return(rspec.create(:user_status, :active, name: 'Active'))
    rspec.allow(UserStatus).to rspec.receive(:default_inactive_status)
                                    .and_return(rspec.create(:user_status, :inactive, name: 'Inactive'))
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
end
