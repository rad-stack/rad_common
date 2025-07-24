module Pace
  class CompanyDetails < Base
    attr_accessor :id

    attr_accessor :logo

    attr_accessor :disclaimer


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'logo' => :'logo',
        :'disclaimer' => :'disclaimer'
      }
    end
  end
end
