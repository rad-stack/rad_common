module Pace
  class ToDoItemNote < Base
    attr_accessor :note

    attr_accessor :type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'note' => :'note',
        :'type' => :'type'
      }
    end
  end
end
