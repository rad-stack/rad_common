module Pace
  class JobPartOutsidePurch < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :outside_purchase_markup

    attr_accessor :quantity

    attr_accessor :manual

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :vendor

    attr_accessor :alt_currency_rate_source

    attr_accessor :uom

    attr_accessor :outside_purchase_setup_markup

    attr_accessor :outside_purchase_setup_markup_forced

    attr_accessor :outside_purchase_template

    attr_accessor :used

    attr_accessor :unit_price

    attr_accessor :activity_code

    attr_accessor :job_contact

    attr_accessor :total_cost

    attr_accessor :date_required

    attr_accessor :quote_num

    attr_accessor :mweight

    attr_accessor :vendor_contact

    attr_accessor :purchased_quantity

    attr_accessor :reviewed_for_po

    attr_accessor :setup_cost

    attr_accessor :outside_purchase_description_template

    attr_accessor :setup_activity_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'quantity' => :'quantity',
        :'manual' => :'manual',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'vendor' => :'vendor',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'uom' => :'uom',
        :'outside_purchase_setup_markup' => :'outsidePurchaseSetupMarkup',
        :'outside_purchase_setup_markup_forced' => :'outsidePurchaseSetupMarkupForced',
        :'outside_purchase_template' => :'outsidePurchaseTemplate',
        :'used' => :'used',
        :'unit_price' => :'unitPrice',
        :'activity_code' => :'activityCode',
        :'job_contact' => :'jobContact',
        :'total_cost' => :'totalCost',
        :'date_required' => :'dateRequired',
        :'quote_num' => :'quoteNum',
        :'mweight' => :'mweight',
        :'vendor_contact' => :'vendorContact',
        :'purchased_quantity' => :'purchasedQuantity',
        :'reviewed_for_po' => :'reviewedForPO',
        :'setup_cost' => :'setupCost',
        :'outside_purchase_description_template' => :'outsidePurchaseDescriptionTemplate',
        :'setup_activity_code' => :'setupActivityCode'
      }
    end
  end
end
