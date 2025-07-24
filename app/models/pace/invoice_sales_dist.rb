module Pace
  class InvoiceSalesDist < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :sales_category

    attr_accessor :manual

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :tax_base

    attr_accessor :charge_back_account

    attr_accessor :invoice

    attr_accessor :job_part_reference

    attr_accessor :memo_created

    attr_accessor :memo_created_date

    attr_accessor :adjusted_total

    attr_accessor :job_product_reference

    attr_accessor :amount_adjustment

    attr_accessor :comm_base


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'sales_category' => :'salesCategory',
        :'manual' => :'manual',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'tax_base' => :'taxBase',
        :'charge_back_account' => :'chargeBackAccount',
        :'invoice' => :'invoice',
        :'job_part_reference' => :'jobPartReference',
        :'memo_created' => :'memoCreated',
        :'memo_created_date' => :'memoCreatedDate',
        :'adjusted_total' => :'adjustedTotal',
        :'job_product_reference' => :'jobProductReference',
        :'amount_adjustment' => :'amountAdjustment',
        :'comm_base' => :'commBase'
      }
    end
  end
end
