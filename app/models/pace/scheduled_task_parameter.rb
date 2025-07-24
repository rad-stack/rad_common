module Pace
  class ScheduledTaskParameter < Base
    attr_accessor :id

    attr_accessor :expression

    attr_accessor :parameter_type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :expression_type

    attr_accessor :scheduled_task

    attr_accessor :report_parameter

    attr_accessor :parameter_name

    attr_accessor :parameter_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'expression' => :'expression',
        :'parameter_type' => :'parameterType',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'expression_type' => :'expressionType',
        :'scheduled_task' => :'scheduledTask',
        :'report_parameter' => :'reportParameter',
        :'parameter_name' => :'parameterName',
        :'parameter_value' => :'parameterValue'
      }
    end
  end
end
