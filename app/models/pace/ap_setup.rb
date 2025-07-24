module Pace
  class APSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :vendor_number

    attr_accessor :gl_register_number_sequence

    attr_accessor :misc_vendor_number

    attr_accessor :print_check_number

    attr_accessor :default_vendor_type

    attr_accessor :default1099_type

    attr_accessor :aging4_days

    attr_accessor :interface_gl

    attr_accessor :checks_bank_account

    attr_accessor :interface_job_cost

    attr_accessor :aging1_days

    attr_accessor :allow_process_all

    attr_accessor :print_stub_gl_detail

    attr_accessor :default_terms

    attr_accessor :printing_checks

    attr_accessor :discounts_gl_account

    attr_accessor :clear_zero_pmt

    attr_accessor :aging2_days

    attr_accessor :print_zero_amt_checks

    attr_accessor :prepaid_bank_account

    attr_accessor :advanced_taxing

    attr_accessor :stub_lines

    attr_accessor :check_stubs

    attr_accessor :search_by_vendor_name

    attr_accessor :allow_duplicate_invoice_numbers

    attr_accessor :interface_bank_rec

    attr_accessor :apply_credits_to_last_aging

    attr_accessor :aging3_days

    attr_accessor :aging_date

    attr_accessor :default1096_contact


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
        :'vendor_number' => :'vendorNumber',
        :'gl_register_number_sequence' => :'glRegisterNumberSequence',
        :'misc_vendor_number' => :'miscVendorNumber',
        :'print_check_number' => :'printCheckNumber',
        :'default_vendor_type' => :'defaultVendorType',
        :'default1099_type' => :'default1099Type',
        :'aging4_days' => :'aging4Days',
        :'interface_gl' => :'interfaceGL',
        :'checks_bank_account' => :'checksBankAccount',
        :'interface_job_cost' => :'interfaceJobCost',
        :'aging1_days' => :'aging1Days',
        :'allow_process_all' => :'allowProcessAll',
        :'print_stub_gl_detail' => :'printStubGLDetail',
        :'default_terms' => :'defaultTerms',
        :'printing_checks' => :'printingChecks',
        :'discounts_gl_account' => :'discountsGLAccount',
        :'clear_zero_pmt' => :'clearZeroPmt',
        :'aging2_days' => :'aging2Days',
        :'print_zero_amt_checks' => :'printZeroAmtChecks',
        :'prepaid_bank_account' => :'prepaidBankAccount',
        :'advanced_taxing' => :'advancedTaxing',
        :'stub_lines' => :'stubLines',
        :'check_stubs' => :'checkStubs',
        :'search_by_vendor_name' => :'searchByVendorName',
        :'allow_duplicate_invoice_numbers' => :'allowDuplicateInvoiceNumbers',
        :'interface_bank_rec' => :'interfaceBankRec',
        :'apply_credits_to_last_aging' => :'applyCreditsToLastAging',
        :'aging3_days' => :'aging3Days',
        :'aging_date' => :'agingDate',
        :'default1096_contact' => :'default1096Contact'
      }
    end
  end
end
