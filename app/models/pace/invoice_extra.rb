module Pace
  class InvoiceExtra < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manual

    attr_accessor :posted

    attr_accessor :price

    attr_accessor :invoice

    attr_accessor :job_part_reference

    attr_accessor :memo_created

    attr_accessor :memo_created_date

    attr_accessor :adjusted_total

    attr_accessor :job_product_reference

    attr_accessor :source_data

    attr_accessor :line_num

    attr_accessor :price_adjustment

    attr_accessor :deposit_receivable

    attr_accessor :invoice_extra_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manual' => :'manual',
        :'posted' => :'posted',
        :'price' => :'price',
        :'invoice' => :'invoice',
        :'job_part_reference' => :'jobPartReference',
        :'memo_created' => :'memoCreated',
        :'memo_created_date' => :'memoCreatedDate',
        :'adjusted_total' => :'adjustedTotal',
        :'job_product_reference' => :'jobProductReference',
        :'source_data' => :'sourceData',
        :'line_num' => :'lineNum',
        :'price_adjustment' => :'priceAdjustment',
        :'deposit_receivable' => :'depositReceivable',
        :'invoice_extra_type' => :'invoiceExtraType'
      }
    end
  end
end
