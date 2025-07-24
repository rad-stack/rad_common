module Pace
  class NonPlannedReason < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :bill_rate

    attr_accessor :schedule_status

    attr_accessor :included_in_wip


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'bill_rate' => :'billRate',
        :'schedule_status' => :'scheduleStatus',
        :'included_in_wip' => :'includedInWIP'
      }
    end
  end
end
