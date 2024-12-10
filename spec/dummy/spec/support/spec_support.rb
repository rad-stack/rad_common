require 'rad_rspec/radical_spec_support'
class SpecSupport < RadicalSpecSupport
  def self.before_all
    rspec = yield
    rspec.allow_any_instance_of(RadicalSendGrid).to rspec.receive(:sendgrid_enabled?).and_return false
    rspec.allow_any_instance_of(Division).to rspec.receive(:notify_owner).and_return(nil)
    super
  end
end
