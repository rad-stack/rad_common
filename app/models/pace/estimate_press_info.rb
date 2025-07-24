module Pace
  class EstimatePressInfo < Base
    attr_accessor :primary_press

    attr_accessor :run_size_h

    attr_accessor :run_size_w

    attr_accessor :run_method

    attr_accessor :run_size_grain_direction


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'primary_press' => :'primaryPress',
        :'run_size_h' => :'runSizeH',
        :'run_size_w' => :'runSizeW',
        :'run_method' => :'runMethod',
        :'run_size_grain_direction' => :'runSizeGrainDirection'
      }
    end
  end
end
