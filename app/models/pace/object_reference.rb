module Pace
  class ObjectReference < Base
    attr_accessor :object_name

    attr_accessor :schema

    attr_accessor :primary_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'object_name' => :'objectName',
        :'schema' => :'schema',
        :'primary_key' => :'primaryKey'
      }
    end
  end
end
