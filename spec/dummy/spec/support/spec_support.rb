require 'rad_rspec/rad_spec_support'
class SpecSupport < RadSpecSupport
  def self.before_all
    rspec = yield
    rspec.allow_any_instance_of(RadSendGrid).to rspec.receive(:sendgrid_enabled?).and_return false
    rspec.allow_any_instance_of(Division).to rspec.receive(:notify_owner).and_return(nil)
    rspec.allow(EmbeddingService).to rspec.receive(:enabled?).and_return false
    super
  end
end
