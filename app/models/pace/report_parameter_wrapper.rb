module Pace
  class ReportParameterWrapper < Base
    attr_accessor :report_parameter_id

    attr_accessor :value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'report_parameter_id' => :'reportParameterId',
        :'value' => :'value'
      }
    end
  end
end
