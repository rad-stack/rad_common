module Pace
  class JobStatusReason < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_status

    attr_accessor :ask_comments

    attr_accessor :dsf_on_hold_reason


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_status' => :'jobStatus',
        :'ask_comments' => :'askComments',
        :'dsf_on_hold_reason' => :'dsfOnHoldReason'
      }
    end
  end
end
