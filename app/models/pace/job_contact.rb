module Pace
  class JobContact < Base
    attr_accessor :id

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job

    attr_accessor :customer

    attr_accessor :vendor

    attr_accessor :contact_type

    attr_accessor :bill_to

    attr_accessor :ship_to


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job' => :'job',
        :'customer' => :'customer',
        :'vendor' => :'vendor',
        :'contact_type' => :'contactType',
        :'bill_to' => :'billTo',
        :'ship_to' => :'shipTo'
      }
    end
  end
end
