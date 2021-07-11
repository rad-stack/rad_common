require 'rad_common/engine'

module RadCommon
  VALID_IMAGE_TYPES = %w[image/png image/jpeg image/jpg].freeze
  VALID_CONTENT_TYPE_MESSAGE = 'has an invalid content type of %<content_type>s, must be %<authorized_types>s'.freeze
end
