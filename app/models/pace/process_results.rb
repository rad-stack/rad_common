module Pace
  class ProcessResults < Base
    attr_accessor :failures

    attr_accessor :successful

    attr_accessor :successes


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'failures' => :'failures',
        :'successful' => :'successful',
        :'successes' => :'successes'
      }
    end
  end
end
