module Pace
  class AutoBillLine < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :discount_amount

    attr_accessor :invoice_amount

    attr_accessor :gl_account

    attr_accessor :tax_amount

    attr_accessor :discount_applicable

    attr_accessor :taxed_basis

    attr_accessor :tax_code

    attr_accessor :auto_bill


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'discount_amount' => :'discountAmount',
        :'invoice_amount' => :'invoiceAmount',
        :'gl_account' => :'glAccount',
        :'tax_amount' => :'taxAmount',
        :'discount_applicable' => :'discountApplicable',
        :'taxed_basis' => :'taxedBasis',
        :'tax_code' => :'taxCode',
        :'auto_bill' => :'autoBill'
      }
    end
  end
end
