module Pace
  class EstimateActivity < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :source

    attr_accessor :units

    attr_accessor :hours

    attr_accessor :detail

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :estimate_source

    attr_accessor :paper_markup

    attr_accessor :inventory_item

    attr_accessor :correlation_id

    attr_accessor :markup

    attr_accessor :estimate_quantity

    attr_accessor :cost

    attr_accessor :activity_code

    attr_accessor :include_in_additional_per_m

    attr_accessor :quote_item_type

    attr_accessor :ganged_hours

    attr_accessor :over_all_sell_markup_cost

    attr_accessor :over_all_markup_cost

    attr_accessor :target_sell

    attr_accessor :out_side_purch_setup

    attr_accessor :out_side_purch_markup

    attr_accessor :out_side_purch_setup_markup

    attr_accessor :over_all_markup

    attr_accessor :over_all_sell_markup

    attr_accessor :commission_base


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'source' => :'source',
        :'units' => :'units',
        :'hours' => :'hours',
        :'detail' => :'detail',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'estimate_source' => :'estimateSource',
        :'paper_markup' => :'paperMarkup',
        :'inventory_item' => :'inventoryItem',
        :'correlation_id' => :'correlationId',
        :'markup' => :'markup',
        :'estimate_quantity' => :'estimateQuantity',
        :'cost' => :'cost',
        :'activity_code' => :'activityCode',
        :'include_in_additional_per_m' => :'includeInAdditionalPerM',
        :'quote_item_type' => :'quoteItemType',
        :'ganged_hours' => :'gangedHours',
        :'over_all_sell_markup_cost' => :'overAllSellMarkupCost',
        :'over_all_markup_cost' => :'overAllMarkupCost',
        :'target_sell' => :'targetSell',
        :'out_side_purch_setup' => :'outSidePurchSetup',
        :'out_side_purch_markup' => :'outSidePurchMarkup',
        :'out_side_purch_setup_markup' => :'outSidePurchSetupMarkup',
        :'over_all_markup' => :'overAllMarkup',
        :'over_all_sell_markup' => :'overAllSellMarkup',
        :'commission_base' => :'commissionBase'
      }
    end
  end
end
