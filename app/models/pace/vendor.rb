module Pace
  class Vendor < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :active

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :aging_current

    attr_accessor :sales_tax2

    attr_accessor :default_currency

    attr_accessor :contact_last_name

    attr_accessor :alt_state

    attr_accessor :account_title

    attr_accessor :alt_address3

    attr_accessor :alt_address1

    attr_accessor :alt_address2

    attr_accessor :registration_number

    attr_accessor :contact_first_name

    attr_accessor :business_id_number

    attr_accessor :bsb_id

    attr_accessor :state_key

    attr_accessor :sage50_accounting_enabled

    attr_accessor :alt_country

    attr_accessor :phone_number

    attr_accessor :payment_method

    attr_accessor :salutation

    attr_accessor :alt_city

    attr_accessor :ship_to_alt

    attr_accessor :ship_via

    attr_accessor :aging2

    attr_accessor :aging3

    attr_accessor :aging1

    attr_accessor :bank_account_id

    attr_accessor :aging4

    attr_accessor :jeeves_accounting_enabled

    attr_accessor :alt_salutation

    attr_accessor :terms

    attr_accessor :alt_zip

    attr_accessor :zip

    attr_accessor :iban_account_id

    attr_accessor :city

    attr_accessor :sage200_accounting_enabled

    attr_accessor :swift_number

    attr_accessor :legal_entity

    attr_accessor :contact_title

    attr_accessor :ship_to_contact

    attr_accessor :map_site_url

    attr_accessor :manufacturing_location

    attr_accessor :alt_state_key

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :vatid_number

    attr_accessor :fax_number

    attr_accessor :gl_account

    attr_accessor :ten_ninety_nine_type

    attr_accessor :last_payment_date

    attr_accessor :bank_account

    attr_accessor :default_activity_code

    attr_accessor :default_freight_on_board

    attr_accessor :account_number

    attr_accessor :routing_number

    attr_accessor :setup_date

    attr_accessor :taxable_code1

    attr_accessor :old_gl_location

    attr_accessor :taxable_code2

    attr_accessor :email_address

    attr_accessor :web_site_address

    attr_accessor :ytd_purch

    attr_accessor :sales_tax1

    attr_accessor :remittance_delivery_method

    attr_accessor :paper_global_discount

    attr_accessor :current_balance

    attr_accessor :tax_number

    attr_accessor :ship_from_alt

    attr_accessor :paper_use_last_bracket

    attr_accessor :purchase_limit

    attr_accessor :time_due

    attr_accessor :old_gl_account

    attr_accessor :payment_contact

    attr_accessor :print1099

    attr_accessor :auto_post_due_day

    attr_accessor :ytd_payments

    attr_accessor :last_auto_post_date

    attr_accessor :vendor_type

    attr_accessor :prior_year_purchase_dollars

    attr_accessor :po_lines_taxable

    attr_accessor :payment_alt

    attr_accessor :ship_from_contact

    attr_accessor :vendor_legal_name

    attr_accessor :auto_post_amount

    attr_accessor :customer_number

    attr_accessor :last_invoice_date

    attr_accessor :lead_time_days


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'active' => :'active',
        :'country' => :'country',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'aging_current' => :'agingCurrent',
        :'sales_tax2' => :'salesTax2',
        :'default_currency' => :'defaultCurrency',
        :'contact_last_name' => :'contactLastName',
        :'alt_state' => :'altState',
        :'account_title' => :'accountTitle',
        :'alt_address3' => :'altAddress3',
        :'alt_address1' => :'altAddress1',
        :'alt_address2' => :'altAddress2',
        :'registration_number' => :'registrationNumber',
        :'contact_first_name' => :'contactFirstName',
        :'business_id_number' => :'businessIdNumber',
        :'bsb_id' => :'bsbID',
        :'state_key' => :'stateKey',
        :'sage50_accounting_enabled' => :'sage50AccountingEnabled',
        :'alt_country' => :'altCountry',
        :'phone_number' => :'phoneNumber',
        :'payment_method' => :'paymentMethod',
        :'salutation' => :'salutation',
        :'alt_city' => :'altCity',
        :'ship_to_alt' => :'shipToAlt',
        :'ship_via' => :'shipVia',
        :'aging2' => :'aging2',
        :'aging3' => :'aging3',
        :'aging1' => :'aging1',
        :'bank_account_id' => :'bankAccountID',
        :'aging4' => :'aging4',
        :'jeeves_accounting_enabled' => :'jeevesAccountingEnabled',
        :'alt_salutation' => :'altSalutation',
        :'terms' => :'terms',
        :'alt_zip' => :'altZip',
        :'zip' => :'zip',
        :'iban_account_id' => :'ibanAccountID',
        :'city' => :'city',
        :'sage200_accounting_enabled' => :'sage200AccountingEnabled',
        :'swift_number' => :'swiftNumber',
        :'legal_entity' => :'legalEntity',
        :'contact_title' => :'contactTitle',
        :'ship_to_contact' => :'shipToContact',
        :'map_site_url' => :'mapSiteURL',
        :'manufacturing_location' => :'manufacturingLocation',
        :'alt_state_key' => :'altStateKey',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'vatid_number' => :'vatidNumber',
        :'fax_number' => :'faxNumber',
        :'gl_account' => :'glAccount',
        :'ten_ninety_nine_type' => :'tenNinetyNineType',
        :'last_payment_date' => :'lastPaymentDate',
        :'bank_account' => :'bankAccount',
        :'default_activity_code' => :'defaultActivityCode',
        :'default_freight_on_board' => :'defaultFreightOnBoard',
        :'account_number' => :'accountNumber',
        :'routing_number' => :'routingNumber',
        :'setup_date' => :'setupDate',
        :'taxable_code1' => :'taxableCode1',
        :'old_gl_location' => :'oldGLLocation',
        :'taxable_code2' => :'taxableCode2',
        :'email_address' => :'emailAddress',
        :'web_site_address' => :'webSiteAddress',
        :'ytd_purch' => :'ytdPurch',
        :'sales_tax1' => :'salesTax1',
        :'remittance_delivery_method' => :'remittanceDeliveryMethod',
        :'paper_global_discount' => :'paperGlobalDiscount',
        :'current_balance' => :'currentBalance',
        :'tax_number' => :'taxNumber',
        :'ship_from_alt' => :'shipFromAlt',
        :'paper_use_last_bracket' => :'paperUseLastBracket',
        :'purchase_limit' => :'purchaseLimit',
        :'time_due' => :'timeDue',
        :'old_gl_account' => :'oldGLAccount',
        :'payment_contact' => :'paymentContact',
        :'print1099' => :'print1099',
        :'auto_post_due_day' => :'autoPostDueDay',
        :'ytd_payments' => :'ytdPayments',
        :'last_auto_post_date' => :'lastAutoPostDate',
        :'vendor_type' => :'vendorType',
        :'prior_year_purchase_dollars' => :'priorYearPurchaseDollars',
        :'po_lines_taxable' => :'poLinesTaxable',
        :'payment_alt' => :'paymentAlt',
        :'ship_from_contact' => :'shipFromContact',
        :'vendor_legal_name' => :'vendorLegalName',
        :'auto_post_amount' => :'autoPostAmount',
        :'customer_number' => :'customerNumber',
        :'last_invoice_date' => :'lastInvoiceDate',
        :'lead_time_days' => :'leadTimeDays'
      }
    end
  end
end
