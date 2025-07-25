module Pace
  class ValueObject < Base
    attr_accessor :fields

    attr_accessor :children

    attr_accessor :primary_key

    attr_accessor :object_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'fields' => :'fields',
        :'children' => :'children',
        :'primary_key' => :'primaryKey',
        :'object_name' => :'objectName'
      }
    end
  end
end
