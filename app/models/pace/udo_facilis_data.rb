module Pace
  class UDOFacilisData < Base
    attr_accessor :id

    attr_accessor :result

    attr_accessor :u_tags


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'result' => :'result',
        :'u_tags' => :'u_tags'
      }
    end
  end
end
