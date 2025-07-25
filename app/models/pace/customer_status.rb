module Pace
  class CustomerStatus < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :customer_active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :status_type

    attr_accessor :credit_hold_job_status

    attr_accessor :credit_hold

    attr_accessor :credit_hold_note


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'customer_active' => :'customerActive',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'status_type' => :'statusType',
        :'credit_hold_job_status' => :'creditHoldJobStatus',
        :'credit_hold' => :'creditHold',
        :'credit_hold_note' => :'creditHoldNote'
      }
    end
  end
end
