require 'rad_rspec/radical_spec_support'
class SpecSupport < RadicalSpecSupport
  def self.before_all(rspec)
    rspec.instance_eval do
      allow_any_instance_of(RadicalSendGrid).to receive(:sendgrid_enabled?).and_return false
      allow_any_instance_of(Division).to receive(:notify_owner).and_return(nil)
    end
    super
  end
end
