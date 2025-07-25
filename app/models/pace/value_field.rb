module Pace
  class ValueField < Base
    attr_accessor :name

    attr_accessor :value

    attr_accessor :type

    attr_accessor :xpath


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'value' => :'value',
        :'type' => :'type',
        :'xpath' => :'xpath'
      }
    end
  end
end
