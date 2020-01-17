require 'rad_common/engine'

module RadCommon
  # Enables/Disables user avatars being uploaded and displayed in the application
  cattr_accessor :use_avatar

  def self.setup
    yield self
  end
end
