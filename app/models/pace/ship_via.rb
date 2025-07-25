module Pace
  class ShipVia < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :provider

    attr_accessor :description

    attr_accessor :maximum_weight

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :dsf_entity

    attr_accessor :dsf_shared

    attr_accessor :max_weight_per_box

    attr_accessor :activity_code

    attr_accessor :alt_description

    attr_accessor :earliest_delivery_time

    attr_accessor :cut_off_time

    attr_accessor :hours_in_transit

    attr_accessor :bill_of_lading

    attr_accessor :fed_ex_method

    attr_accessor :multi_box_shipping

    attr_accessor :dsf_delivery_method

    attr_accessor :upsmethod

    attr_accessor :avail_for_relay

    attr_accessor :date_calc_type

    attr_accessor :external_code_for_handling_charge

    attr_accessor :daysintransit

    attr_accessor :available_in_ecommerce

    attr_accessor :minimum_weight

    attr_accessor :external_code_for_tax

    attr_accessor :legacy_tracking_url


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'provider' => :'provider',
        :'description' => :'description',
        :'maximum_weight' => :'maximumWeight',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'dsf_entity' => :'dsfEntity',
        :'dsf_shared' => :'dsfShared',
        :'max_weight_per_box' => :'maxWeightPerBox',
        :'activity_code' => :'activityCode',
        :'alt_description' => :'altDescription',
        :'earliest_delivery_time' => :'earliestDeliveryTime',
        :'cut_off_time' => :'cutOffTime',
        :'hours_in_transit' => :'hoursInTransit',
        :'bill_of_lading' => :'billOfLading',
        :'fed_ex_method' => :'fedExMethod',
        :'multi_box_shipping' => :'multiBoxShipping',
        :'dsf_delivery_method' => :'dsfDeliveryMethod',
        :'upsmethod' => :'upsmethod',
        :'avail_for_relay' => :'availForRelay',
        :'date_calc_type' => :'dateCalcType',
        :'external_code_for_handling_charge' => :'externalCodeForHandlingCharge',
        :'daysintransit' => :'daysintransit',
        :'available_in_ecommerce' => :'availableInEcommerce',
        :'minimum_weight' => :'minimumWeight',
        :'external_code_for_tax' => :'externalCodeForTax',
        :'legacy_tracking_url' => :'legacyTrackingUrl'
      }
    end
  end
end
