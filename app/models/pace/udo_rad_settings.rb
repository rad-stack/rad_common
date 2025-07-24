module Pace
  class UDORadSettings < Base
    attr_accessor :id

    attr_accessor :default_phoenix_jobtype

    attr_accessor :u_tags

    attr_accessor :default_nash_jobtype


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'default_phoenix_jobtype' => :'default_phoenix_jobtype',
        :'u_tags' => :'u_tags',
        :'default_nash_jobtype' => :'default_nash_jobtype'
      }
    end
  end
end
