module Pace
  class AssetDepBatch < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :date_setup

    attr_accessor :manual

    attr_accessor :entered_by

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :approved

    attr_accessor :reversal

    attr_accessor :gl_accounting_period


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'date' => :'date',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'date_setup' => :'dateSetup',
        :'manual' => :'manual',
        :'entered_by' => :'enteredBy',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'approved' => :'approved',
        :'reversal' => :'reversal',
        :'gl_accounting_period' => :'glAccountingPeriod'
      }
    end
  end
end
