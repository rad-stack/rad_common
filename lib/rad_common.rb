require 'rad_common/engine'

module RadCommon
  # Enables/Disables user avatars being uploaded and displayed in the application
  cattr_accessor :use_avatar
  @@use_avatar = false

  cattr_accessor :disable_sign_up
  @@disable_sign_up = false

  def self.setup
    yield self
  end
end
