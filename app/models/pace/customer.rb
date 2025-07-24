module Pace
  class Customer < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :language

    attr_accessor :country

    attr_accessor :description

    attr_accessor :password

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :csr

    attr_accessor :shipment_message

    attr_accessor :aging_current

    attr_accessor :phone_extension

    attr_accessor :date_last_payment

    attr_accessor :aging2_percent

    attr_accessor :aging_service_charge1

    attr_accessor :aging_service_charge2

    attr_accessor :sales_category

    attr_accessor :aging_service_charge3

    attr_accessor :aging_service_charge4

    attr_accessor :sales_tax2

    attr_accessor :default_currency

    attr_accessor :quota

    attr_accessor :statement_cycle

    attr_accessor :default_ecommerce_ship_method

    attr_accessor :plant_manager_id

    attr_accessor :pageflex_deployment

    attr_accessor :iway_customer_id

    attr_accessor :cart_message

    attr_accessor :use_alternate_text

    attr_accessor :crm_id

    attr_accessor :avg_payment_days

    attr_accessor :default_dsf_contact

    attr_accessor :default_days_until_job_due

    attr_accessor :source_type

    attr_accessor :parent_customer

    attr_accessor :contact_last_name

    attr_accessor :include_tax_in_discount

    attr_accessor :certification_authority

    attr_accessor :alt_state

    attr_accessor :point_of_title_transfer

    attr_accessor :account_title

    attr_accessor :job_product_invoice_line_description

    attr_accessor :use_price_list_pricing

    attr_accessor :web_site

    attr_accessor :alt_address3

    attr_accessor :alt_address1

    attr_accessor :alt_address2

    attr_accessor :tax_num

    attr_accessor :print_stream_customer

    attr_accessor :shared_secret

    attr_accessor :bill_to_contact

    attr_accessor :highest_balance

    attr_accessor :io_id1

    attr_accessor :overall_sell_markup

    attr_accessor :email_punchout_admin

    attr_accessor :aging_service_charge_current

    attr_accessor :overall_markup

    attr_accessor :registration_number

    attr_accessor :bill_rate

    attr_accessor :punchout_identity

    attr_accessor :contact_first_name

    attr_accessor :proof_contact

    attr_accessor :punchout_hub_id

    attr_accessor :certification_level

    attr_accessor :default_product_group

    attr_accessor :calculate_tax

    attr_accessor :sales_ytd

    attr_accessor :business_id_number

    attr_accessor :aging_total

    attr_accessor :auto_add_contact

    attr_accessor :look_and_feel

    attr_accessor :customer_legal_name

    attr_accessor :bsb_id

    attr_accessor :credit_limit

    attr_accessor :export

    attr_accessor :state_key

    attr_accessor :allow_failed_freight_checkout

    attr_accessor :sage50_accounting_enabled

    attr_accessor :calculate_freight

    attr_accessor :alt_country

    attr_accessor :wip_balance

    attr_accessor :sic_number

    attr_accessor :bill_to_alt

    attr_accessor :enter_job_po_required

    attr_accessor :phone_number

    attr_accessor :tax_i_dexpires

    attr_accessor :default_contact

    attr_accessor :consolidate_invoices

    attr_accessor :job_invoice_line_description

    attr_accessor :printable_inventory_token

    attr_accessor :payment_method

    attr_accessor :salutation

    attr_accessor :alt_city

    attr_accessor :ship_bill_to_alt

    attr_accessor :default_quote_letter_type

    attr_accessor :ship_to_alt

    attr_accessor :price_list

    attr_accessor :unposted_payment_balance

    attr_accessor :ship_via

    attr_accessor :aging2

    attr_accessor :aging3

    attr_accessor :display_price

    attr_accessor :sales_person_alt

    attr_accessor :aging1

    attr_accessor :bank_account_id

    attr_accessor :aging4

    attr_accessor :dsf_entity

    attr_accessor :dsf_shared

    attr_accessor :printable_job_ticket_token

    attr_accessor :discount_percent

    attr_accessor :job_difficulty

    attr_accessor :taxable_code

    attr_accessor :date_last_invoice

    attr_accessor :aging4_percent

    attr_accessor :jeeves_accounting_enabled

    attr_accessor :allowable_overs

    attr_accessor :revenue_type

    attr_accessor :value_added_markup

    attr_accessor :alt_salutation

    attr_accessor :aging1_percent

    attr_accessor :contact_num

    attr_accessor :date_setup

    attr_accessor :terms

    attr_accessor :alt_zip

    attr_accessor :apply_discount_to_invoice

    attr_accessor :enter_invoice_po_required

    attr_accessor :zip

    attr_accessor :sales_last_year

    attr_accessor :iban_account_id

    attr_accessor :outside_purchase_markup

    attr_accessor :alternate_phone_number

    attr_accessor :dsf_customer

    attr_accessor :probability

    attr_accessor :aging3_percent

    attr_accessor :ship_in_name_of

    attr_accessor :customer_type_aging_total_percent

    attr_accessor :shipping_markup

    attr_accessor :alternate_phone_extension

    attr_accessor :default_payment_method

    attr_accessor :city

    attr_accessor :job_part_invoice_line_description

    attr_accessor :non_value_added_markup

    attr_accessor :statement_delivery_method

    attr_accessor :ecommerce_check_out_note

    attr_accessor :job_part_item_invoice_line_description

    attr_accessor :sage200_accounting_enabled

    attr_accessor :dunning_letter_delivery_method

    attr_accessor :network_location

    attr_accessor :delivery_zone

    attr_accessor :fax_extension

    attr_accessor :cust_name

    attr_accessor :next_service_charge_date

    attr_accessor :employee_count_type

    attr_accessor :job_material_invoice_line_description

    attr_accessor :sales_person

    attr_accessor :account_balance

    attr_accessor :credit_card_processing_enabled

    attr_accessor :profile_token

    attr_accessor :swift_number

    attr_accessor :printable_token

    attr_accessor :sales_tax

    attr_accessor :legal_entity

    attr_accessor :customer_type

    attr_accessor :print_stream_shared

    attr_accessor :contact_title

    attr_accessor :finance_charge

    attr_accessor :customer_group

    attr_accessor :invoice_delivery_method

    attr_accessor :tax_category

    attr_accessor :ship_to_contact

    attr_accessor :map_site_url

    attr_accessor :process_print_stream_items

    attr_accessor :shipping_acct_num

    attr_accessor :ship_bill_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :order_alert

    attr_accessor :alt_state_key

    attr_accessor :eservice_message

    attr_accessor :job_notes

    attr_accessor :default_job

    attr_accessor :customer_status

    attr_accessor :credit_check

    attr_accessor :industry_type

    attr_accessor :require_bill_of_lading_per_job

    attr_accessor :default_alt

    attr_accessor :on_credit_hold

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :date_high_balance

    attr_accessor :address1

    attr_accessor :print_num_invoices

    attr_accessor :vatid_number

    attr_accessor :ship_to_format

    attr_accessor :paper_markup

    attr_accessor :fax_number

    attr_accessor :invoice_message

    attr_accessor :printable_company_id

    attr_accessor :vendor_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'language' => :'language',
        :'country' => :'country',
        :'description' => :'description',
        :'password' => :'password',
        :'email' => :'email',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'csr' => :'csr',
        :'shipment_message' => :'shipmentMessage',
        :'aging_current' => :'agingCurrent',
        :'phone_extension' => :'phoneExtension',
        :'date_last_payment' => :'dateLastPayment',
        :'aging2_percent' => :'aging2Percent',
        :'aging_service_charge1' => :'agingServiceCharge1',
        :'aging_service_charge2' => :'agingServiceCharge2',
        :'sales_category' => :'salesCategory',
        :'aging_service_charge3' => :'agingServiceCharge3',
        :'aging_service_charge4' => :'agingServiceCharge4',
        :'sales_tax2' => :'salesTax2',
        :'default_currency' => :'defaultCurrency',
        :'quota' => :'quota',
        :'statement_cycle' => :'statementCycle',
        :'default_ecommerce_ship_method' => :'defaultEcommerceShipMethod',
        :'plant_manager_id' => :'plantManagerId',
        :'pageflex_deployment' => :'pageflexDeployment',
        :'iway_customer_id' => :'iwayCustomerID',
        :'cart_message' => :'cartMessage',
        :'use_alternate_text' => :'useAlternateText',
        :'crm_id' => :'crmId',
        :'avg_payment_days' => :'avgPaymentDays',
        :'default_dsf_contact' => :'defaultDsfContact',
        :'default_days_until_job_due' => :'defaultDaysUntilJobDue',
        :'source_type' => :'sourceType',
        :'parent_customer' => :'parentCustomer',
        :'contact_last_name' => :'contactLastName',
        :'include_tax_in_discount' => :'includeTaxInDiscount',
        :'certification_authority' => :'certificationAuthority',
        :'alt_state' => :'altState',
        :'point_of_title_transfer' => :'pointOfTitleTransfer',
        :'account_title' => :'accountTitle',
        :'job_product_invoice_line_description' => :'jobProductInvoiceLineDescription',
        :'use_price_list_pricing' => :'usePriceListPricing',
        :'web_site' => :'webSite',
        :'alt_address3' => :'altAddress3',
        :'alt_address1' => :'altAddress1',
        :'alt_address2' => :'altAddress2',
        :'tax_num' => :'taxNum',
        :'print_stream_customer' => :'printStreamCustomer',
        :'shared_secret' => :'sharedSecret',
        :'bill_to_contact' => :'billToContact',
        :'highest_balance' => :'highestBalance',
        :'io_id1' => :'ioID1',
        :'overall_sell_markup' => :'overallSellMarkup',
        :'email_punchout_admin' => :'emailPunchoutAdmin',
        :'aging_service_charge_current' => :'agingServiceChargeCurrent',
        :'overall_markup' => :'overallMarkup',
        :'registration_number' => :'registrationNumber',
        :'bill_rate' => :'billRate',
        :'punchout_identity' => :'punchoutIdentity',
        :'contact_first_name' => :'contactFirstName',
        :'proof_contact' => :'proofContact',
        :'punchout_hub_id' => :'punchoutHubId',
        :'certification_level' => :'certificationLevel',
        :'default_product_group' => :'defaultProductGroup',
        :'calculate_tax' => :'calculateTax',
        :'sales_ytd' => :'salesYTD',
        :'business_id_number' => :'businessIdNumber',
        :'aging_total' => :'agingTotal',
        :'auto_add_contact' => :'autoAddContact',
        :'look_and_feel' => :'lookAndFeel',
        :'customer_legal_name' => :'customerLegalName',
        :'bsb_id' => :'bsbID',
        :'credit_limit' => :'creditLimit',
        :'export' => :'export',
        :'state_key' => :'stateKey',
        :'allow_failed_freight_checkout' => :'allowFailedFreightCheckout',
        :'sage50_accounting_enabled' => :'sage50AccountingEnabled',
        :'calculate_freight' => :'calculateFreight',
        :'alt_country' => :'altCountry',
        :'wip_balance' => :'wipBalance',
        :'sic_number' => :'sicNumber',
        :'bill_to_alt' => :'billToAlt',
        :'enter_job_po_required' => :'enterJobPORequired',
        :'phone_number' => :'phoneNumber',
        :'tax_i_dexpires' => :'taxIDexpires',
        :'default_contact' => :'defaultContact',
        :'consolidate_invoices' => :'consolidateInvoices',
        :'job_invoice_line_description' => :'jobInvoiceLineDescription',
        :'printable_inventory_token' => :'printableInventoryToken',
        :'payment_method' => :'paymentMethod',
        :'salutation' => :'salutation',
        :'alt_city' => :'altCity',
        :'ship_bill_to_alt' => :'shipBillToAlt',
        :'default_quote_letter_type' => :'defaultQuoteLetterType',
        :'ship_to_alt' => :'shipToAlt',
        :'price_list' => :'priceList',
        :'unposted_payment_balance' => :'unpostedPaymentBalance',
        :'ship_via' => :'shipVia',
        :'aging2' => :'aging2',
        :'aging3' => :'aging3',
        :'display_price' => :'displayPrice',
        :'sales_person_alt' => :'salesPersonAlt',
        :'aging1' => :'aging1',
        :'bank_account_id' => :'bankAccountID',
        :'aging4' => :'aging4',
        :'dsf_entity' => :'dsfEntity',
        :'dsf_shared' => :'dsfShared',
        :'printable_job_ticket_token' => :'printableJobTicketToken',
        :'discount_percent' => :'discountPercent',
        :'job_difficulty' => :'jobDifficulty',
        :'taxable_code' => :'taxableCode',
        :'date_last_invoice' => :'dateLastInvoice',
        :'aging4_percent' => :'aging4Percent',
        :'jeeves_accounting_enabled' => :'jeevesAccountingEnabled',
        :'allowable_overs' => :'allowableOvers',
        :'revenue_type' => :'revenueType',
        :'value_added_markup' => :'valueAddedMarkup',
        :'alt_salutation' => :'altSalutation',
        :'aging1_percent' => :'aging1Percent',
        :'contact_num' => :'contactNum',
        :'date_setup' => :'dateSetup',
        :'terms' => :'terms',
        :'alt_zip' => :'altZip',
        :'apply_discount_to_invoice' => :'applyDiscountToInvoice',
        :'enter_invoice_po_required' => :'enterInvoicePORequired',
        :'zip' => :'zip',
        :'sales_last_year' => :'salesLastYear',
        :'iban_account_id' => :'ibanAccountID',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'alternate_phone_number' => :'alternatePhoneNumber',
        :'dsf_customer' => :'dsfCustomer',
        :'probability' => :'probability',
        :'aging3_percent' => :'aging3Percent',
        :'ship_in_name_of' => :'shipInNameOf',
        :'customer_type_aging_total_percent' => :'customerTypeAgingTotalPercent',
        :'shipping_markup' => :'shippingMarkup',
        :'alternate_phone_extension' => :'alternatePhoneExtension',
        :'default_payment_method' => :'defaultPaymentMethod',
        :'city' => :'city',
        :'job_part_invoice_line_description' => :'jobPartInvoiceLineDescription',
        :'non_value_added_markup' => :'nonValueAddedMarkup',
        :'statement_delivery_method' => :'statementDeliveryMethod',
        :'ecommerce_check_out_note' => :'ecommerceCheckOutNote',
        :'job_part_item_invoice_line_description' => :'jobPartItemInvoiceLineDescription',
        :'sage200_accounting_enabled' => :'sage200AccountingEnabled',
        :'dunning_letter_delivery_method' => :'dunningLetterDeliveryMethod',
        :'network_location' => :'networkLocation',
        :'delivery_zone' => :'deliveryZone',
        :'fax_extension' => :'faxExtension',
        :'cust_name' => :'custName',
        :'next_service_charge_date' => :'nextServiceChargeDate',
        :'employee_count_type' => :'employeeCountType',
        :'job_material_invoice_line_description' => :'jobMaterialInvoiceLineDescription',
        :'sales_person' => :'salesPerson',
        :'account_balance' => :'accountBalance',
        :'credit_card_processing_enabled' => :'creditCardProcessingEnabled',
        :'profile_token' => :'profileToken',
        :'swift_number' => :'swiftNumber',
        :'printable_token' => :'printableToken',
        :'sales_tax' => :'salesTax',
        :'legal_entity' => :'legalEntity',
        :'customer_type' => :'customerType',
        :'print_stream_shared' => :'printStreamShared',
        :'contact_title' => :'contactTitle',
        :'finance_charge' => :'financeCharge',
        :'customer_group' => :'customerGroup',
        :'invoice_delivery_method' => :'invoiceDeliveryMethod',
        :'tax_category' => :'taxCategory',
        :'ship_to_contact' => :'shipToContact',
        :'map_site_url' => :'mapSiteURL',
        :'process_print_stream_items' => :'processPrintStreamItems',
        :'shipping_acct_num' => :'shippingAcctNum',
        :'ship_bill_to_contact' => :'shipBillToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'order_alert' => :'orderAlert',
        :'alt_state_key' => :'altStateKey',
        :'eservice_message' => :'eserviceMessage',
        :'job_notes' => :'jobNotes',
        :'default_job' => :'defaultJob',
        :'customer_status' => :'customerStatus',
        :'credit_check' => :'creditCheck',
        :'industry_type' => :'industryType',
        :'require_bill_of_lading_per_job' => :'requireBillOfLadingPerJob',
        :'default_alt' => :'defaultAlt',
        :'on_credit_hold' => :'onCreditHold',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'date_high_balance' => :'dateHighBalance',
        :'address1' => :'address1',
        :'print_num_invoices' => :'printNumInvoices',
        :'vatid_number' => :'vatidNumber',
        :'ship_to_format' => :'shipToFormat',
        :'paper_markup' => :'paperMarkup',
        :'fax_number' => :'faxNumber',
        :'invoice_message' => :'invoiceMessage',
        :'printable_company_id' => :'printableCompanyID',
        :'vendor_number' => :'vendorNumber'
      }
    end
  end
end
