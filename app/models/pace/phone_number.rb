module Pace
  class PhoneNumber < Base
    attr_accessor :number

    attr_accessor :type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'number' => :'number',
        :'type' => :'type'
      }
    end
  end
end
