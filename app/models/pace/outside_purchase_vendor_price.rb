module Pace
  class OutsidePurchaseVendorPrice < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :outside_purchase_markup

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :vendor

    attr_accessor :uom

    attr_accessor :outside_purchase_setup_markup

    attr_accessor :outside_purchase_setup_markup_forced

    attr_accessor :outside_purchase_template

    attr_accessor :unit_price

    attr_accessor :vendor_contact

    attr_accessor :up_to_quantity

    attr_accessor :setup_cost


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'outside_purchase_markup' => :'outsidePurchaseMarkup',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'vendor' => :'vendor',
        :'uom' => :'uom',
        :'outside_purchase_setup_markup' => :'outsidePurchaseSetupMarkup',
        :'outside_purchase_setup_markup_forced' => :'outsidePurchaseSetupMarkupForced',
        :'outside_purchase_template' => :'outsidePurchaseTemplate',
        :'unit_price' => :'unitPrice',
        :'vendor_contact' => :'vendorContact',
        :'up_to_quantity' => :'upToQuantity',
        :'setup_cost' => :'setupCost'
      }
    end
  end
end
