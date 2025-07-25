module Pace
  class ValueObjectsGroup < Base
    attr_accessor :value_objects

    attr_accessor :total_records

    attr_accessor :object_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'value_objects' => :'valueObjects',
        :'total_records' => :'totalRecords',
        :'object_name' => :'objectName'
      }
    end
  end
end
