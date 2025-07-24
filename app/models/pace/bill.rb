module Pace
  class Bill < Base
    attr_accessor :name

    attr_accessor :reference

    attr_accessor :id

    attr_accessor :comments

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :invoice_date

    attr_accessor :discount_percent

    attr_accessor :terms

    attr_accessor :manufacturing_location

    attr_accessor :posted

    attr_accessor :date_time_setup

    attr_accessor :reversal

    attr_accessor :original_id

    attr_accessor :amount_to_pay

    attr_accessor :expected_payment_date

    attr_accessor :adjust_off

    attr_accessor :discount_amount

    attr_accessor :invoice_amount

    attr_accessor :lock_discount_amount

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :date_due_forced

    attr_accessor :review

    attr_accessor :voucher_date

    attr_accessor :gl_account

    attr_accessor :check_number

    attr_accessor :ten_ninety_nine_type

    attr_accessor :group_check

    attr_accessor :pay

    attr_accessor :pay_with_discount

    attr_accessor :bill_batch

    attr_accessor :payment_period

    attr_accessor :adjustment_amount

    attr_accessor :paid_amount

    attr_accessor :po_number

    attr_accessor :discount_date_due

    attr_accessor :discounts_taken

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :posting_status

    attr_accessor :vendor

    attr_accessor :bill_status

    attr_accessor :invoice_number

    attr_accessor :last_payment_date

    attr_accessor :alt_currency_rate_source

    attr_accessor :date_due

    attr_accessor :bill_type

    attr_accessor :reverse_bill_id

    attr_accessor :check_date

    attr_accessor :un_pay

    attr_accessor :amount_due

    attr_accessor :discount_taken

    attr_accessor :exported_to3rd_party

    attr_accessor :pending_bill_payment_batch

    attr_accessor :bank_account


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'reference' => :'reference',
        :'id' => :'id',
        :'comments' => :'comments',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'invoice_date' => :'invoiceDate',
        :'discount_percent' => :'discountPercent',
        :'terms' => :'terms',
        :'manufacturing_location' => :'manufacturingLocation',
        :'posted' => :'posted',
        :'date_time_setup' => :'dateTimeSetup',
        :'reversal' => :'reversal',
        :'original_id' => :'originalId',
        :'amount_to_pay' => :'amountToPay',
        :'expected_payment_date' => :'expectedPaymentDate',
        :'adjust_off' => :'adjustOff',
        :'discount_amount' => :'discountAmount',
        :'invoice_amount' => :'invoiceAmount',
        :'lock_discount_amount' => :'lockDiscountAmount',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'date_due_forced' => :'dateDueForced',
        :'review' => :'review',
        :'voucher_date' => :'voucherDate',
        :'gl_account' => :'glAccount',
        :'check_number' => :'checkNumber',
        :'ten_ninety_nine_type' => :'tenNinetyNineType',
        :'group_check' => :'groupCheck',
        :'pay' => :'pay',
        :'pay_with_discount' => :'payWithDiscount',
        :'bill_batch' => :'billBatch',
        :'payment_period' => :'paymentPeriod',
        :'adjustment_amount' => :'adjustmentAmount',
        :'paid_amount' => :'paidAmount',
        :'po_number' => :'poNumber',
        :'discount_date_due' => :'discountDateDue',
        :'discounts_taken' => :'discountsTaken',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'posting_status' => :'postingStatus',
        :'vendor' => :'vendor',
        :'bill_status' => :'billStatus',
        :'invoice_number' => :'invoiceNumber',
        :'last_payment_date' => :'lastPaymentDate',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'date_due' => :'dateDue',
        :'bill_type' => :'billType',
        :'reverse_bill_id' => :'reverseBillId',
        :'check_date' => :'checkDate',
        :'un_pay' => :'unPay',
        :'amount_due' => :'amountDue',
        :'discount_taken' => :'discountTaken',
        :'exported_to3rd_party' => :'exportedTo3rdParty',
        :'pending_bill_payment_batch' => :'pendingBillPaymentBatch',
        :'bank_account' => :'bankAccount'
      }
    end
  end
end
