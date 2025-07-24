module Pace
  class AutoInvoiceLine < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :quantity

    attr_accessor :start_date

    attr_accessor :uom

    attr_accessor :unit_price

    attr_accessor :alt_description

    attr_accessor :line_type

    attr_accessor :billing_code

    attr_accessor :line_num

    attr_accessor :end_date

    attr_accessor :auto_invoice


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'quantity' => :'quantity',
        :'start_date' => :'startDate',
        :'uom' => :'uom',
        :'unit_price' => :'unitPrice',
        :'alt_description' => :'altDescription',
        :'line_type' => :'lineType',
        :'billing_code' => :'billingCode',
        :'line_num' => :'lineNum',
        :'end_date' => :'endDate',
        :'auto_invoice' => :'autoInvoice'
      }
    end
  end
end
