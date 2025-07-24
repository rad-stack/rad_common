module Pace
  class OutsidePurchaseTemplate < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_vendor

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :estimate_quantity

    attr_accessor :unit_price

    attr_accessor :activity_code

    attr_accessor :mweight

    attr_accessor :vendor_contact

    attr_accessor :setup_price

    attr_accessor :default_uom

    attr_accessor :description_template

    attr_accessor :setup_activity_code

    attr_accessor :job_part_quantity

    attr_accessor :default_outside_purchase_setup_markup

    attr_accessor :default_outside_purchase_setup_markup_forced

    attr_accessor :default_outside_purchase_markup


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_vendor' => :'defaultVendor',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'estimate_quantity' => :'estimateQuantity',
        :'unit_price' => :'unitPrice',
        :'activity_code' => :'activityCode',
        :'mweight' => :'mweight',
        :'vendor_contact' => :'vendorContact',
        :'setup_price' => :'setupPrice',
        :'default_uom' => :'defaultUom',
        :'description_template' => :'descriptionTemplate',
        :'setup_activity_code' => :'setupActivityCode',
        :'job_part_quantity' => :'jobPartQuantity',
        :'default_outside_purchase_setup_markup' => :'defaultOutsidePurchaseSetupMarkup',
        :'default_outside_purchase_setup_markup_forced' => :'defaultOutsidePurchaseSetupMarkupForced',
        :'default_outside_purchase_markup' => :'defaultOutsidePurchaseMarkup'
      }
    end
  end
end
