module Pace
  class Estimate < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :state

    attr_accessor :debug

    attr_accessor :description

    attr_accessor :status

    attr_accessor :activity

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :csr

    attr_accessor :certification_authority

    attr_accessor :bill_to_contact

    attr_accessor :certification_level

    attr_accessor :taxable_code

    attr_accessor :sales_person

    attr_accessor :sales_tax

    attr_accessor :legal_entity

    attr_accessor :ship_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :available_manufacturing_locations

    attr_accessor :user_interface_set

    attr_accessor :total_pages

    attr_accessor :total_parts

    attr_accessor :entry_date_time

    attr_accessor :add_crm_opportunity

    attr_accessor :add_crm_activity

    attr_accessor :due_date

    attr_accessor :estimate_request

    attr_accessor :product_binding_type

    attr_accessor :run_date

    attr_accessor :metrix_id

    attr_accessor :estimator

    attr_accessor :quote_letter_type

    attr_accessor :bias_ganging

    attr_accessor :repetitive_runs

    attr_accessor :freight_on_board

    attr_accessor :opportunity

    attr_accessor :auto_add_quote_letter

    attr_accessor :customer_prospect_name

    attr_accessor :manual_estimate_item_workflow_was_enabled

    attr_accessor :prospect_phone_ext

    attr_accessor :from_estimate_request

    attr_accessor :estimate_version_number

    attr_accessor :from_job

    attr_accessor :lost_to

    attr_accessor :prospect_email

    attr_accessor :follow_up_date

    attr_accessor :allow_vat

    attr_accessor :manual_estimate_item_workflow

    attr_accessor :mailing_information

    attr_accessor :special_information

    attr_accessor :lost_reason

    attr_accessor :from_combo

    attr_accessor :selected_shipment_pos

    attr_accessor :delivery_date

    attr_accessor :prospect_country

    attr_accessor :lost_date

    attr_accessor :prospect_address2

    attr_accessor :previous_estimate_version_number

    attr_accessor :prospect_address3

    attr_accessor :last_job

    attr_accessor :prospect_address1

    attr_accessor :prepress_information

    attr_accessor :prospect_state

    attr_accessor :previous_estimate_num

    attr_accessor :version_description

    attr_accessor :last_changed_date_time

    attr_accessor :paper_information

    attr_accessor :job_project

    attr_accessor :committed_from_metrix

    attr_accessor :price_summary_level

    attr_accessor :prospect_company

    attr_accessor :sorted_positions

    attr_accessor :prospect_fax

    attr_accessor :prospect_zip

    attr_accessor :manufacturing_location_forced

    attr_accessor :prospect_phone

    attr_accessor :reward_date

    attr_accessor :prospect_name

    attr_accessor :next_estimate_version_number

    attr_accessor :allow_multiple_sheet_sizes

    attr_accessor :lost_quantiy

    attr_accessor :previously_calced_with_debug

    attr_accessor :calc_page_id

    attr_accessor :highest_estimate_version

    attr_accessor :finishing_information

    attr_accessor :lost_amount

    attr_accessor :prospect_fax_ext

    attr_accessor :estimate_number

    attr_accessor :prospect_city

    attr_accessor :has_ganged_estimate_parts_on_estimate_layouts

    attr_accessor :prospect_state_key

    attr_accessor :budget_amount

    attr_accessor :last_changed_by

    attr_accessor :recreate_layout

    attr_accessor :force_quoted_price_on_convert


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'state' => :'state',
        :'debug' => :'debug',
        :'description' => :'description',
        :'status' => :'status',
        :'activity' => :'activity',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'csr' => :'csr',
        :'certification_authority' => :'certificationAuthority',
        :'bill_to_contact' => :'billToContact',
        :'certification_level' => :'certificationLevel',
        :'taxable_code' => :'taxableCode',
        :'sales_person' => :'salesPerson',
        :'sales_tax' => :'salesTax',
        :'legal_entity' => :'legalEntity',
        :'ship_to_contact' => :'shipToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'available_manufacturing_locations' => :'availableManufacturingLocations',
        :'user_interface_set' => :'userInterfaceSet',
        :'total_pages' => :'totalPages',
        :'total_parts' => :'totalParts',
        :'entry_date_time' => :'entryDateTime',
        :'add_crm_opportunity' => :'addCRMOpportunity',
        :'add_crm_activity' => :'addCRMActivity',
        :'due_date' => :'dueDate',
        :'estimate_request' => :'estimateRequest',
        :'product_binding_type' => :'productBindingType',
        :'run_date' => :'runDate',
        :'metrix_id' => :'metrixID',
        :'estimator' => :'estimator',
        :'quote_letter_type' => :'quoteLetterType',
        :'bias_ganging' => :'biasGanging',
        :'repetitive_runs' => :'repetitiveRuns',
        :'freight_on_board' => :'freightOnBoard',
        :'opportunity' => :'opportunity',
        :'auto_add_quote_letter' => :'autoAddQuoteLetter',
        :'customer_prospect_name' => :'customerProspectName',
        :'manual_estimate_item_workflow_was_enabled' => :'manualEstimateItemWorkflowWasEnabled',
        :'prospect_phone_ext' => :'prospectPhoneExt',
        :'from_estimate_request' => :'fromEstimateRequest',
        :'estimate_version_number' => :'estimateVersionNumber',
        :'from_job' => :'fromJob',
        :'lost_to' => :'lostTo',
        :'prospect_email' => :'prospectEmail',
        :'follow_up_date' => :'followUpDate',
        :'allow_vat' => :'allowVAT',
        :'manual_estimate_item_workflow' => :'manualEstimateItemWorkflow',
        :'mailing_information' => :'mailingInformation',
        :'special_information' => :'specialInformation',
        :'lost_reason' => :'lostReason',
        :'from_combo' => :'fromCombo',
        :'selected_shipment_pos' => :'selectedShipmentPos',
        :'delivery_date' => :'deliveryDate',
        :'prospect_country' => :'prospectCountry',
        :'lost_date' => :'lostDate',
        :'prospect_address2' => :'prospectAddress2',
        :'previous_estimate_version_number' => :'previousEstimateVersionNumber',
        :'prospect_address3' => :'prospectAddress3',
        :'last_job' => :'lastJob',
        :'prospect_address1' => :'prospectAddress1',
        :'prepress_information' => :'prepressInformation',
        :'prospect_state' => :'prospectState',
        :'previous_estimate_num' => :'previousEstimateNum',
        :'version_description' => :'versionDescription',
        :'last_changed_date_time' => :'lastChangedDateTime',
        :'paper_information' => :'paperInformation',
        :'job_project' => :'jobProject',
        :'committed_from_metrix' => :'committedFromMetrix',
        :'price_summary_level' => :'priceSummaryLevel',
        :'prospect_company' => :'prospectCompany',
        :'sorted_positions' => :'sortedPositions',
        :'prospect_fax' => :'prospectFax',
        :'prospect_zip' => :'prospectZip',
        :'manufacturing_location_forced' => :'manufacturingLocationForced',
        :'prospect_phone' => :'prospectPhone',
        :'reward_date' => :'rewardDate',
        :'prospect_name' => :'prospectName',
        :'next_estimate_version_number' => :'nextEstimateVersionNumber',
        :'allow_multiple_sheet_sizes' => :'allowMultipleSheetSizes',
        :'lost_quantiy' => :'lostQuantiy',
        :'previously_calced_with_debug' => :'previouslyCalcedWithDebug',
        :'calc_page_id' => :'calcPageId',
        :'highest_estimate_version' => :'highestEstimateVersion',
        :'finishing_information' => :'finishingInformation',
        :'lost_amount' => :'lostAmount',
        :'prospect_fax_ext' => :'prospectFaxExt',
        :'estimate_number' => :'estimateNumber',
        :'prospect_city' => :'prospectCity',
        :'has_ganged_estimate_parts_on_estimate_layouts' => :'hasGangedEstimatePartsOnEstimateLayouts',
        :'prospect_state_key' => :'prospectStateKey',
        :'budget_amount' => :'budgetAmount',
        :'last_changed_by' => :'lastChangedBy',
        :'recreate_layout' => :'recreateLayout',
        :'force_quoted_price_on_convert' => :'forceQuotedPriceOnConvert'
      }
    end
  end
end
