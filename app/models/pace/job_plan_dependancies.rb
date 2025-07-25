module Pace
  class JobPlanDependancies < Base
    attr_accessor :id

    attr_accessor :task

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_plan

    attr_accessor :down_stream


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'task' => :'task',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_plan' => :'jobPlan',
        :'down_stream' => :'downStream'
      }
    end
  end
end
