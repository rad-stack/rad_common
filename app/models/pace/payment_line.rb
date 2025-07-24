module Pace
  class PaymentLine < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sales_category

    attr_accessor :posted

    attr_accessor :note

    attr_accessor :amount

    attr_accessor :adjust_off

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :gl_account

    attr_accessor :pay

    attr_accessor :pay_with_discount

    attr_accessor :adjustment_amount

    attr_accessor :po_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :discount_taken

    attr_accessor :tax_base

    attr_accessor :tax_amount

    attr_accessor :tax_code

    attr_accessor :receivable

    attr_accessor :payment

    attr_accessor :pnref

    attr_accessor :receivable_payment_group_line

    attr_accessor :entry_type

    attr_accessor :capture_amount

    attr_accessor :total_amount

    attr_accessor :deposit_type

    attr_accessor :single_job


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sales_category' => :'salesCategory',
        :'posted' => :'posted',
        :'note' => :'note',
        :'amount' => :'amount',
        :'adjust_off' => :'adjustOff',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'gl_account' => :'glAccount',
        :'pay' => :'pay',
        :'pay_with_discount' => :'payWithDiscount',
        :'adjustment_amount' => :'adjustmentAmount',
        :'po_number' => :'poNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'discount_taken' => :'discountTaken',
        :'tax_base' => :'taxBase',
        :'tax_amount' => :'taxAmount',
        :'tax_code' => :'taxCode',
        :'receivable' => :'receivable',
        :'payment' => :'payment',
        :'pnref' => :'pnref',
        :'receivable_payment_group_line' => :'receivablePaymentGroupLine',
        :'entry_type' => :'entryType',
        :'capture_amount' => :'captureAmount',
        :'total_amount' => :'totalAmount',
        :'deposit_type' => :'depositType',
        :'single_job' => :'singleJob'
      }
    end
  end
end
