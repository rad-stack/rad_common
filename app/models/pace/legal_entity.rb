module Pace
  class LegalEntity < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :invoice_number

    attr_accessor :invoice_prefix


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'invoice_number' => :'invoiceNumber',
        :'invoice_prefix' => :'invoicePrefix'
      }
    end
  end
end
