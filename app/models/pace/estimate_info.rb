module Pace
  class EstimateInfo < Base
    attr_accessor :estimate_number

    attr_accessor :estimate_description

    attr_accessor :customer

    attr_accessor :sales_person

    attr_accessor :contact

    attr_accessor :freight_on_board

    attr_accessor :estimator

    attr_accessor :follow_up_date

    attr_accessor :due_date

    attr_accessor :delivery_date

    attr_accessor :budget_amount

    attr_accessor :notes

    attr_accessor :prospect_company

    attr_accessor :prospect_name

    attr_accessor :prospect_address1

    attr_accessor :prospect_address2

    attr_accessor :prospect_address3

    attr_accessor :prospect_city

    attr_accessor :prospect_state

    attr_accessor :prospect_zip

    attr_accessor :prospect_phone

    attr_accessor :prospect_phone_ext

    attr_accessor :prospect_fax

    attr_accessor :prospect_fax_ext

    attr_accessor :prospect_country

    attr_accessor :prospect_email

    attr_accessor :reference

    attr_accessor :sales_tax

    attr_accessor :alt_currency

    attr_accessor :taxable_code

    attr_accessor :opportunity

    attr_accessor :activity

    attr_accessor :estimate_part_info

    attr_accessor :fsc_certification

    attr_accessor :add_crm_opportunity

    attr_accessor :add_crm_activity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'estimate_number' => :'estimateNumber',
        :'estimate_description' => :'estimateDescription',
        :'customer' => :'customer',
        :'sales_person' => :'salesPerson',
        :'contact' => :'contact',
        :'freight_on_board' => :'freightOnBoard',
        :'estimator' => :'estimator',
        :'follow_up_date' => :'followUpDate',
        :'due_date' => :'dueDate',
        :'delivery_date' => :'deliveryDate',
        :'budget_amount' => :'budgetAmount',
        :'notes' => :'notes',
        :'prospect_company' => :'prospectCompany',
        :'prospect_name' => :'prospectName',
        :'prospect_address1' => :'prospectAddress1',
        :'prospect_address2' => :'prospectAddress2',
        :'prospect_address3' => :'prospectAddress3',
        :'prospect_city' => :'prospectCity',
        :'prospect_state' => :'prospectState',
        :'prospect_zip' => :'prospectZip',
        :'prospect_phone' => :'prospectPhone',
        :'prospect_phone_ext' => :'prospectPhoneExt',
        :'prospect_fax' => :'prospectFax',
        :'prospect_fax_ext' => :'prospectFaxExt',
        :'prospect_country' => :'prospectCountry',
        :'prospect_email' => :'prospectEmail',
        :'reference' => :'reference',
        :'sales_tax' => :'salesTax',
        :'alt_currency' => :'altCurrency',
        :'taxable_code' => :'taxableCode',
        :'opportunity' => :'opportunity',
        :'activity' => :'activity',
        :'estimate_part_info' => :'estimatePartInfo',
        :'fsc_certification' => :'fscCertification',
        :'add_crm_opportunity' => :'addCRMOpportunity',
        :'add_crm_activity' => :'addCRMActivity'
      }
    end
  end
end
