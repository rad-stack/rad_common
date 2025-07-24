module Pace
  class JobPlanLink < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job

    attr_accessor :note

    attr_accessor :from_job_plan

    attr_accessor :to_job_plan


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job' => :'job',
        :'note' => :'note',
        :'from_job_plan' => :'fromJobPlan',
        :'to_job_plan' => :'toJobPlan'
      }
    end
  end
end
