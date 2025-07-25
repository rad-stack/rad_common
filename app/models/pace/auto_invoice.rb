module Pace
  class AutoInvoice < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :cycle

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_job

    attr_accessor :customer

    attr_accessor :auto_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'cycle' => :'cycle',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_job' => :'defaultJob',
        :'customer' => :'customer',
        :'auto_date' => :'autoDate'
      }
    end
  end
end
