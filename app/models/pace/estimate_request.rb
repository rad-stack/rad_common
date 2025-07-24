module Pace
  class EstimateRequest < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :description

    attr_accessor :status

    attr_accessor :activity

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :certification_authority

    attr_accessor :bill_to_contact

    attr_accessor :certification_level

    attr_accessor :taxable_code

    attr_accessor :sales_person

    attr_accessor :sales_tax

    attr_accessor :ship_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :estimate

    attr_accessor :user_interface_set

    attr_accessor :entry_date_time

    attr_accessor :add_crm_opportunity

    attr_accessor :add_crm_activity

    attr_accessor :due_date

    attr_accessor :product_binding_type

    attr_accessor :estimator

    attr_accessor :quote_letter_type

    attr_accessor :repetitive_runs

    attr_accessor :freight_on_board

    attr_accessor :opportunity

    attr_accessor :auto_add_quote_letter

    attr_accessor :customer_prospect_name

    attr_accessor :prospect_phone_ext

    attr_accessor :estimate_version_number

    attr_accessor :prospect_email

    attr_accessor :follow_up_date

    attr_accessor :allow_vat

    attr_accessor :mailing_information

    attr_accessor :special_information

    attr_accessor :delivery_date

    attr_accessor :prospect_country

    attr_accessor :prospect_address2

    attr_accessor :prospect_address3

    attr_accessor :prospect_address1

    attr_accessor :prepress_information

    attr_accessor :prospect_state

    attr_accessor :last_changed_date_time

    attr_accessor :paper_information

    attr_accessor :prospect_company

    attr_accessor :prospect_fax

    attr_accessor :prospect_zip

    attr_accessor :prospect_phone

    attr_accessor :prospect_name

    attr_accessor :next_estimate_version_number

    attr_accessor :highest_estimate_version

    attr_accessor :finishing_information

    attr_accessor :prospect_fax_ext

    attr_accessor :estimate_number

    attr_accessor :prospect_city

    attr_accessor :prospect_state_key

    attr_accessor :budget_amount

    attr_accessor :last_changed_by

    attr_accessor :can_estimate_be_created

    attr_accessor :total_products


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'description' => :'description',
        :'status' => :'status',
        :'activity' => :'activity',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'certification_authority' => :'certificationAuthority',
        :'bill_to_contact' => :'billToContact',
        :'certification_level' => :'certificationLevel',
        :'taxable_code' => :'taxableCode',
        :'sales_person' => :'salesPerson',
        :'sales_tax' => :'salesTax',
        :'ship_to_contact' => :'shipToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'estimate' => :'estimate',
        :'user_interface_set' => :'userInterfaceSet',
        :'entry_date_time' => :'entryDateTime',
        :'add_crm_opportunity' => :'addCRMOpportunity',
        :'add_crm_activity' => :'addCRMActivity',
        :'due_date' => :'dueDate',
        :'product_binding_type' => :'productBindingType',
        :'estimator' => :'estimator',
        :'quote_letter_type' => :'quoteLetterType',
        :'repetitive_runs' => :'repetitiveRuns',
        :'freight_on_board' => :'freightOnBoard',
        :'opportunity' => :'opportunity',
        :'auto_add_quote_letter' => :'autoAddQuoteLetter',
        :'customer_prospect_name' => :'customerProspectName',
        :'prospect_phone_ext' => :'prospectPhoneExt',
        :'estimate_version_number' => :'estimateVersionNumber',
        :'prospect_email' => :'prospectEmail',
        :'follow_up_date' => :'followUpDate',
        :'allow_vat' => :'allowVAT',
        :'mailing_information' => :'mailingInformation',
        :'special_information' => :'specialInformation',
        :'delivery_date' => :'deliveryDate',
        :'prospect_country' => :'prospectCountry',
        :'prospect_address2' => :'prospectAddress2',
        :'prospect_address3' => :'prospectAddress3',
        :'prospect_address1' => :'prospectAddress1',
        :'prepress_information' => :'prepressInformation',
        :'prospect_state' => :'prospectState',
        :'last_changed_date_time' => :'lastChangedDateTime',
        :'paper_information' => :'paperInformation',
        :'prospect_company' => :'prospectCompany',
        :'prospect_fax' => :'prospectFax',
        :'prospect_zip' => :'prospectZip',
        :'prospect_phone' => :'prospectPhone',
        :'prospect_name' => :'prospectName',
        :'next_estimate_version_number' => :'nextEstimateVersionNumber',
        :'highest_estimate_version' => :'highestEstimateVersion',
        :'finishing_information' => :'finishingInformation',
        :'prospect_fax_ext' => :'prospectFaxExt',
        :'estimate_number' => :'estimateNumber',
        :'prospect_city' => :'prospectCity',
        :'prospect_state_key' => :'prospectStateKey',
        :'budget_amount' => :'budgetAmount',
        :'last_changed_by' => :'lastChangedBy',
        :'can_estimate_be_created' => :'canEstimateBeCreated',
        :'total_products' => :'totalProducts'
      }
    end
  end
end
