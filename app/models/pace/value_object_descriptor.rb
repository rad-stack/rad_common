module Pace
  class ValueObjectDescriptor < Base
    attr_accessor :fields

    attr_accessor :offset

    attr_accessor :children

    attr_accessor :primary_key

    attr_accessor :xpath_filter

    attr_accessor :object_name

    attr_accessor :xpath_sorts

    attr_accessor :limit


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'fields' => :'fields',
        :'offset' => :'offset',
        :'children' => :'children',
        :'primary_key' => :'primaryKey',
        :'xpath_filter' => :'xpathFilter',
        :'object_name' => :'objectName',
        :'xpath_sorts' => :'xpathSorts',
        :'limit' => :'limit'
      }
    end
  end
end
