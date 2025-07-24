module Pace
  class XPathDataSort < Base
    attr_accessor :xpath

    attr_accessor :descending


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'xpath' => :'xpath',
        :'descending' => :'descending'
      }
    end
  end
end
