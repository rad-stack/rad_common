module Pace
  class JobTypePlan < Base
    attr_accessor :id

    attr_accessor :hours

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :note

    attr_accessor :activity_code

    attr_accessor :assigned_to

    attr_accessor :job_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'hours' => :'hours',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'note' => :'note',
        :'activity_code' => :'activityCode',
        :'assigned_to' => :'assignedTo',
        :'job_type' => :'jobType'
      }
    end
  end
end
