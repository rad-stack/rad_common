module Pace
  class ShoppingCart < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :payment_method

    attr_accessor :ship_via

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :account

    attr_accessor :purchase_order

    attr_accessor :total_price

    attr_accessor :requested_by

    attr_accessor :total_freight

    attr_accessor :ship_provider

    attr_accessor :sub_total

    attr_accessor :date_checked_out

    attr_accessor :checkout_ready

    attr_accessor :total_tax

    attr_accessor :chargeback_account

    attr_accessor :requested_by_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'payment_method' => :'paymentMethod',
        :'ship_via' => :'shipVia',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'account' => :'account',
        :'purchase_order' => :'purchaseOrder',
        :'total_price' => :'totalPrice',
        :'requested_by' => :'requestedBy',
        :'total_freight' => :'totalFreight',
        :'ship_provider' => :'shipProvider',
        :'sub_total' => :'subTotal',
        :'date_checked_out' => :'dateCheckedOut',
        :'checkout_ready' => :'checkoutReady',
        :'total_tax' => :'totalTax',
        :'chargeback_account' => :'chargebackAccount',
        :'requested_by_forced' => :'requestedByForced'
      }
    end
  end
end
