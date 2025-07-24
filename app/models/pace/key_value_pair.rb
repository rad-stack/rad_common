module Pace
  class KeyValuePair < Base
    attr_accessor :key

    attr_accessor :value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'key' => :'key',
        :'value' => :'value'
      }
    end
  end
end
