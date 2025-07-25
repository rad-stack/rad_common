module Pace
  class FieldDescriptor < Base
    attr_accessor :name

    attr_accessor :xpath


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'xpath' => :'xpath'
      }
    end
  end
end
