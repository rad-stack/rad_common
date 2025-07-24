module Pace
  class DisAllowedAutoChangeableToJobStatus < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_status

    attr_accessor :dis_allowed_job_status


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_status' => :'jobStatus',
        :'dis_allowed_job_status' => :'disAllowedJobStatus'
      }
    end
  end
end
