module Pace
  class ToDoItemFile < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :type

    attr_accessor :group


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'type' => :'type',
        :'group' => :'group'
      }
    end
  end
end
