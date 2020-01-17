require 'rad_common/engine'

module RadCommon
  cattr_accessor :use_avatar

  def self.setup
    yield self
  end
end
