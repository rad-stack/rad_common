module Pace
  class TodoItemItem < Base
    attr_accessor :description

    attr_accessor :quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'description' => :'description',
        :'quantity' => :'quantity'
      }
    end
  end
end
