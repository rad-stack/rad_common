module Pace
  class Quote < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :description

    attr_accessor :status

    attr_accessor :email

    attr_accessor :activity

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :bill_to_contact

    attr_accessor :state_key

    attr_accessor :price_list

    attr_accessor :ship_via

    attr_accessor :discount_percent

    attr_accessor :taxable_code

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :sales_tax

    attr_accessor :legal_entity

    attr_accessor :ship_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :quantity

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :po_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :fax

    attr_accessor :phone

    attr_accessor :additional_description

    attr_accessor :combo_price

    attr_accessor :add_crm_opportunity

    attr_accessor :add_crm_activity

    attr_accessor :quantity_remaining

    attr_accessor :job_type

    attr_accessor :estimator

    attr_accessor :next_sequence

    attr_accessor :quote_number

    attr_accessor :quantity10

    attr_accessor :quantity1

    attr_accessor :quantity2

    attr_accessor :quantity7

    attr_accessor :quantity8

    attr_accessor :quantity9

    attr_accessor :quantity3

    attr_accessor :quantity4

    attr_accessor :quantity5

    attr_accessor :quantity6

    attr_accessor :is_template

    attr_accessor :opportunity

    attr_accessor :job_project

    attr_accessor :converted_job_type

    attr_accessor :quantity_converted

    attr_accessor :job_part_converted_to

    attr_accessor :delivery_date_time

    attr_accessor :previous_quote

    attr_accessor :contact_id

    attr_accessor :customer_name

    attr_accessor :quantity_shipped

    attr_accessor :quote_due_date

    attr_accessor :suspend_calculations

    attr_accessor :rush_charge

    attr_accessor :job_converted_to

    attr_accessor :fax_ext

    attr_accessor :request_date

    attr_accessor :phone_ext

    attr_accessor :each_of

    attr_accessor :update_job_info_on_convert

    attr_accessor :quote_action

    attr_accessor :salesperson


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'description' => :'description',
        :'status' => :'status',
        :'email' => :'email',
        :'activity' => :'activity',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'bill_to_contact' => :'billToContact',
        :'state_key' => :'stateKey',
        :'price_list' => :'priceList',
        :'ship_via' => :'shipVia',
        :'discount_percent' => :'discountPercent',
        :'taxable_code' => :'taxableCode',
        :'zip' => :'zip',
        :'city' => :'city',
        :'sales_tax' => :'salesTax',
        :'legal_entity' => :'legalEntity',
        :'ship_to_contact' => :'shipToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'quantity' => :'quantity',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'po_number' => :'poNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'fax' => :'fax',
        :'phone' => :'phone',
        :'additional_description' => :'additionalDescription',
        :'combo_price' => :'comboPrice',
        :'add_crm_opportunity' => :'addCRMOpportunity',
        :'add_crm_activity' => :'addCRMActivity',
        :'quantity_remaining' => :'quantityRemaining',
        :'job_type' => :'jobType',
        :'estimator' => :'estimator',
        :'next_sequence' => :'nextSequence',
        :'quote_number' => :'quoteNumber',
        :'quantity10' => :'quantity10',
        :'quantity1' => :'quantity1',
        :'quantity2' => :'quantity2',
        :'quantity7' => :'quantity7',
        :'quantity8' => :'quantity8',
        :'quantity9' => :'quantity9',
        :'quantity3' => :'quantity3',
        :'quantity4' => :'quantity4',
        :'quantity5' => :'quantity5',
        :'quantity6' => :'quantity6',
        :'is_template' => :'isTemplate',
        :'opportunity' => :'opportunity',
        :'job_project' => :'jobProject',
        :'converted_job_type' => :'convertedJobType',
        :'quantity_converted' => :'quantityConverted',
        :'job_part_converted_to' => :'jobPartConvertedTo',
        :'delivery_date_time' => :'deliveryDateTime',
        :'previous_quote' => :'previousQuote',
        :'contact_id' => :'contactId',
        :'customer_name' => :'customerName',
        :'quantity_shipped' => :'quantityShipped',
        :'quote_due_date' => :'quoteDueDate',
        :'suspend_calculations' => :'suspendCalculations',
        :'rush_charge' => :'rushCharge',
        :'job_converted_to' => :'jobConvertedTo',
        :'fax_ext' => :'faxExt',
        :'request_date' => :'requestDate',
        :'phone_ext' => :'phoneExt',
        :'each_of' => :'eachOf',
        :'update_job_info_on_convert' => :'updateJobInfoOnConvert',
        :'quote_action' => :'quoteAction',
        :'salesperson' => :'salesperson'
      }
    end
  end
end
