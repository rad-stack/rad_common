module Pace
  class ReportWrapper < Base
    attr_accessor :report_id

    attr_accessor :content

    attr_accessor :base_object_key

    attr_accessor :report_parameter_wrappers


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'report_id' => :'reportId',
        :'content' => :'content',
        :'base_object_key' => :'baseObjectKey',
        :'report_parameter_wrappers' => :'reportParameterWrappers'
      }
    end
  end
end
