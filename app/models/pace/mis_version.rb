module Pace
  class MisVersion < Base
    attr_accessor :build

    attr_accessor :major

    attr_accessor :minor


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'build' => :'build',
        :'major' => :'major',
        :'minor' => :'minor'
      }
    end
  end
end
