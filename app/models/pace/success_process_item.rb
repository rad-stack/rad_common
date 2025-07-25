module Pace
  class SuccessProcessItem < Base
    attr_accessor :object

    attr_accessor :reason


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'object' => :'object',
        :'reason' => :'reason'
      }
    end
  end
end
