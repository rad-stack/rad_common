module Pace
  class PaceQuoteSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quote

    attr_accessor :add_option_type

    attr_accessor :use_manufacturing_location_prefix

    attr_accessor :distribute_price_changes

    attr_accessor :combo_price

    attr_accessor :ecommerce_quote_item_view

    attr_accessor :quote_prefix

    attr_accessor :separate_look_up_and_price_qty

    attr_accessor :calculations_log_level

    attr_accessor :auto_create_contact

    attr_accessor :allow_price_list_override

    attr_accessor :default_convert_to_job_status

    attr_accessor :add_crm_opportunity

    attr_accessor :add_crm_activity

    attr_accessor :administrative_quote_item_view

    attr_accessor :default_price_list

    attr_accessor :add_finishing_part


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quote' => :'quote',
        :'add_option_type' => :'addOptionType',
        :'use_manufacturing_location_prefix' => :'useManufacturingLocationPrefix',
        :'distribute_price_changes' => :'distributePriceChanges',
        :'combo_price' => :'comboPrice',
        :'ecommerce_quote_item_view' => :'ecommerceQuoteItemView',
        :'quote_prefix' => :'quotePrefix',
        :'separate_look_up_and_price_qty' => :'separateLookUpAndPriceQty',
        :'calculations_log_level' => :'calculationsLogLevel',
        :'auto_create_contact' => :'autoCreateContact',
        :'allow_price_list_override' => :'allowPriceListOverride',
        :'default_convert_to_job_status' => :'defaultConvertToJobStatus',
        :'add_crm_opportunity' => :'addCRMOpportunity',
        :'add_crm_activity' => :'addCRMActivity',
        :'administrative_quote_item_view' => :'administrativeQuoteItemView',
        :'default_price_list' => :'defaultPriceList',
        :'add_finishing_part' => :'addFinishingPart'
      }
    end
  end
end
