module Pace
  class Duration < Base
    attr_accessor :seconds

    attr_accessor :nano

    attr_accessor :negative

    attr_accessor :zero

    attr_accessor :units


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'seconds' => :'seconds',
        :'nano' => :'nano',
        :'negative' => :'negative',
        :'zero' => :'zero',
        :'units' => :'units'
      }
    end
  end
end
