module Pace
  class InvoiceCommDist < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :sales_person

    attr_accessor :manual

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :invoice

    attr_accessor :commission_rate

    attr_accessor :job_part_reference

    attr_accessor :memo_created

    attr_accessor :memo_created_date

    attr_accessor :comm_base_adjustment

    attr_accessor :lock_amount

    attr_accessor :adjusted_total

    attr_accessor :lock_comm_base

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
        :'sales_category' => :'salesCategory',
        :'sales_person' => :'salesPerson',
        :'manual' => :'manual',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'invoice' => :'invoice',
        :'commission_rate' => :'commissionRate',
        :'job_part_reference' => :'jobPartReference',
        :'memo_created' => :'memoCreated',
        :'memo_created_date' => :'memoCreatedDate',
        :'comm_base_adjustment' => :'commBaseAdjustment',
        :'lock_amount' => :'lockAmount',
        :'adjusted_total' => :'adjustedTotal',
        :'lock_comm_base' => :'lockCommBase',
        :'job_product_reference' => :'jobProductReference',
        :'amount_adjustment' => :'amountAdjustment',
        :'comm_base' => :'commBase'
      }
    end
  end
end
