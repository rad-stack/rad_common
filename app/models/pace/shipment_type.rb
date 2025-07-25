module Pace
  class ShipmentType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :assignable

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_contact

    attr_accessor :vendor

    attr_accessor :account_number

    attr_accessor :freight_activity_code

    attr_accessor :onsite_installation

    attr_accessor :ship_to_inventory

    attr_accessor :planned

    attr_accessor :package_drop

    attr_accessor :create_inventory_receipt

    attr_accessor :web_shipment

    attr_accessor :skip_inventory_pull_for_job_materials

    attr_accessor :default_contact_to_job_manufacturing_location_contact

    attr_accessor :generate_advanced_shipping_notice

    attr_accessor :show_in_e_service

    attr_accessor :link_shipped_planned

    attr_accessor :unplanned_shipment_type

    attr_accessor :printable_shipped

    attr_accessor :update_shipment_date

    attr_accessor :handling_activity_code

    attr_accessor :add_qty

    attr_accessor :web_address

    attr_accessor :print_carton_packing_slip

    attr_accessor :export_pace_connect

    attr_accessor :print_skid_tag

    attr_accessor :allowed_on_credit_hold

    attr_accessor :print_label

    attr_accessor :update_inventory_item_cost

    attr_accessor :print_del_ticket

    attr_accessor :process_shipper_shared


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'assignable' => :'assignable',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_contact' => :'defaultContact',
        :'vendor' => :'vendor',
        :'account_number' => :'accountNumber',
        :'freight_activity_code' => :'freightActivityCode',
        :'onsite_installation' => :'onsiteInstallation',
        :'ship_to_inventory' => :'shipToInventory',
        :'planned' => :'planned',
        :'package_drop' => :'packageDrop',
        :'create_inventory_receipt' => :'createInventoryReceipt',
        :'web_shipment' => :'webShipment',
        :'skip_inventory_pull_for_job_materials' => :'skipInventoryPullForJobMaterials',
        :'default_contact_to_job_manufacturing_location_contact' => :'defaultContactToJobManufacturingLocationContact',
        :'generate_advanced_shipping_notice' => :'generateAdvancedShippingNotice',
        :'show_in_e_service' => :'showInEService',
        :'link_shipped_planned' => :'linkShippedPlanned',
        :'unplanned_shipment_type' => :'unplannedShipmentType',
        :'printable_shipped' => :'printableShipped',
        :'update_shipment_date' => :'updateShipmentDate',
        :'handling_activity_code' => :'handlingActivityCode',
        :'add_qty' => :'addQty',
        :'web_address' => :'webAddress',
        :'print_carton_packing_slip' => :'printCartonPackingSlip',
        :'export_pace_connect' => :'exportPaceConnect',
        :'print_skid_tag' => :'printSkidTag',
        :'allowed_on_credit_hold' => :'allowedOnCreditHold',
        :'print_label' => :'printLabel',
        :'update_inventory_item_cost' => :'updateInventoryItemCost',
        :'print_del_ticket' => :'printDelTicket',
        :'process_shipper_shared' => :'processShipperShared'
      }
    end
  end
end
