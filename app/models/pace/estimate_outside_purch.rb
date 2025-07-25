module Pace
  class EstimateOutsidePurch < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :certification_authority

    attr_accessor :outside_purchase_markup

    attr_accessor :quantity

    attr_accessor :manual

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :vendor

    attr_accessor :alt_currency_rate_source

    attr_accessor :quantity_forced

    attr_accessor :correlation_id

    attr_accessor :outside_purchase_markup_forced

    attr_accessor :estimate_quantity

    attr_accessor :uom

    attr_accessor :outside_purchase_setup_markup

    attr_accessor :outside_purchase_setup_markup_forced

    attr_accessor :outside_purchase_template

    attr_accessor :used

    attr_accessor :unit_price

    attr_accessor :unit_price_forced

    attr_accessor :activity_code

    attr_accessor :total_cost

    attr_accessor :quote_num

    attr_accessor :mweight

    attr_accessor :description_forced

    attr_accessor :vendor_contact

    attr_accessor :setup_cost

    attr_accessor :outside_purchase_description_template

    attr_accessor :setup_activity_code

    attr_accessor :tax_base_per_m

    attr_accessor :tax_base_setup

    attr_accessor :vendor_certified

    attr_accessor :job_source

    attr_accessor :setup_cost_forced

    attr_accessor :requested


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'description' => :'description',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'certification_authority' => :'certificationAuthority',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'quantity' => :'quantity',
        :'manual' => :'manual',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'vendor' => :'vendor',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'quantity_forced' => :'quantityForced',
        :'correlation_id' => :'correlationId',
        :'outside_purchase_markup_forced' => :'outsidePurchaseMarkupForced',
        :'estimate_quantity' => :'estimateQuantity',
        :'uom' => :'uom',
        :'outside_purchase_setup_markup' => :'outsidePurchaseSetupMarkup',
        :'outside_purchase_setup_markup_forced' => :'outsidePurchaseSetupMarkupForced',
        :'outside_purchase_template' => :'outsidePurchaseTemplate',
        :'used' => :'used',
        :'unit_price' => :'unitPrice',
        :'unit_price_forced' => :'unitPriceForced',
        :'activity_code' => :'activityCode',
        :'total_cost' => :'totalCost',
        :'quote_num' => :'quoteNum',
        :'mweight' => :'mweight',
        :'description_forced' => :'descriptionForced',
        :'vendor_contact' => :'vendorContact',
        :'setup_cost' => :'setupCost',
        :'outside_purchase_description_template' => :'outsidePurchaseDescriptionTemplate',
        :'setup_activity_code' => :'setupActivityCode',
        :'tax_base_per_m' => :'taxBasePerM',
        :'tax_base_setup' => :'taxBaseSetup',
        :'vendor_certified' => :'vendorCertified',
        :'job_source' => :'jobSource',
        :'setup_cost_forced' => :'setupCostForced',
        :'requested' => :'requested'
      }
    end
  end
end
