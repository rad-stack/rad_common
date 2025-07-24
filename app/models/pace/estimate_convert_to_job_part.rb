module Pace
  class EstimateConvertToJobPart < Base
    attr_accessor :estimate_part

    attr_accessor :quantity_to_convert

    attr_accessor :quanities

    attr_accessor :description

    attr_accessor :selected

    attr_accessor :sequence

    attr_accessor :part_number

    attr_accessor :job_type

    attr_accessor :override_addl_per_m

    attr_accessor :override_price


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'estimate_part' => :'estimatePart',
        :'quantity_to_convert' => :'quantityToConvert',
        :'quanities' => :'quanities',
        :'description' => :'description',
        :'selected' => :'selected',
        :'sequence' => :'sequence',
        :'part_number' => :'partNumber',
        :'job_type' => :'jobType',
        :'override_addl_per_m' => :'overrideAddlPerM',
        :'override_price' => :'overridePrice'
      }
    end
  end
end
