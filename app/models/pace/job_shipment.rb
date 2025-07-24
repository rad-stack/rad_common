module Pace
  class JobShipment < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :extension

    attr_accessor :description

    attr_accessor :weight

    attr_accessor :component

    attr_accessor :lot

    attr_accessor :email

    attr_accessor :po_uom

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :assignable

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :proof

    attr_accessor :job

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :state_key

    attr_accessor :salutation

    attr_accessor :ship_via

    attr_accessor :zip

    attr_accessor :ship_in_name_of

    attr_accessor :city

    attr_accessor :ship_bill_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :item_template

    attr_accessor :quantity

    attr_accessor :customer

    attr_accessor :inventory_item

    attr_accessor :quoted_price

    attr_accessor :uom

    attr_accessor :cost

    attr_accessor :date_time

    attr_accessor :shipment_type

    attr_accessor :contact_number

    attr_accessor :tracking_number

    attr_accessor :charge_back_account

    attr_accessor :shipper_name

    attr_accessor :ship_via_note

    attr_accessor :phone

    attr_accessor :inventory_location

    attr_accessor :activity_code

    attr_accessor :invoice

    attr_accessor :account_number

    attr_accessor :assigned_to

    attr_accessor :inventory_cost

    attr_accessor :quantity_remaining

    attr_accessor :scheduled_flag

    attr_accessor :job_contact

    attr_accessor :scheduled

    attr_accessor :use_legacy_print_flow_format

    attr_accessor :dsf_product_id

    attr_accessor :qty_picked

    attr_accessor :revision

    attr_accessor :vendor_lot_no

    attr_accessor :lot_expiration_date

    attr_accessor :inventory_bin_key

    attr_accessor :lot_job_sell_price_per1000

    attr_accessor :carton1_note

    attr_accessor :cod_company_check_acceptable

    attr_accessor :quantity10

    attr_accessor :process_shipper_id

    attr_accessor :bill_of_lading_add

    attr_accessor :print_stream_partial_shipment

    attr_accessor :package_drop_type

    attr_accessor :freight_link_integrated

    attr_accessor :weight_ounces

    attr_accessor :carton1_tracking_number

    attr_accessor :carton2_skid_count

    attr_accessor :carton1_skid_count

    attr_accessor :new_item

    attr_accessor :print_stream_final_partial_shipment

    attr_accessor :xfer_batch

    attr_accessor :print_stream_pull_ticket_id

    attr_accessor :onsite_installation

    attr_accessor :charges

    attr_accessor :proof_shipment

    attr_accessor :note1

    attr_accessor :carton1_count

    attr_accessor :count1

    attr_accessor :ship_to_inventory

    attr_accessor :count2

    attr_accessor :third_party_charges

    attr_accessor :saturday

    attr_accessor :count5

    attr_accessor :count6

    attr_accessor :count3

    attr_accessor :count4

    attr_accessor :carton3_skid_count

    attr_accessor :count9

    attr_accessor :count7

    attr_accessor :created_from_estimate

    attr_accessor :count8

    attr_accessor :planned

    attr_accessor :selling_price

    attr_accessor :carton3_tracking_number

    attr_accessor :handling_cost

    attr_accessor :auto_created

    attr_accessor :inventory_item_type

    attr_accessor :promise_date_time

    attr_accessor :freight_classification_number

    attr_accessor :carton3_note

    attr_accessor :date_forced

    attr_accessor :production_shipment

    attr_accessor :carton2_count

    attr_accessor :child_partial_shipment_count

    attr_accessor :carton1_quantity

    attr_accessor :package_drop

    attr_accessor :count10

    attr_accessor :thickness

    attr_accessor :carton2_note

    attr_accessor :collapsed_in_ui

    attr_accessor :note10

    attr_accessor :fob

    attr_accessor :quantity1

    attr_accessor :quantity2

    attr_accessor :quantity7

    attr_accessor :planned_quantity

    attr_accessor :quantity8

    attr_accessor :quantity9

    attr_accessor :ship_to_inventory_quantity_received

    attr_accessor :quantity3

    attr_accessor :carton2_quantity

    attr_accessor :quantity4

    attr_accessor :quantity5

    attr_accessor :sent_to_process_shipper

    attr_accessor :quantity6

    attr_accessor :shipped

    attr_accessor :carton2_tracking_number

    attr_accessor :quote_shipment

    attr_accessor :note4

    attr_accessor :note5

    attr_accessor :note2

    attr_accessor :forced_account_number

    attr_accessor :note3

    attr_accessor :sent_to_dsf

    attr_accessor :note8

    attr_accessor :note9

    attr_accessor :bill_of_lading

    attr_accessor :note6

    attr_accessor :note7

    attr_accessor :new_inventory_item

    attr_accessor :cost_distribution

    attr_accessor :time_forced

    attr_accessor :carton3_count

    attr_accessor :cod_amount

    attr_accessor :tracking_link

    attr_accessor :tracking_notes

    attr_accessor :carton3_quantity

    attr_accessor :price_per_pouom

    attr_accessor :dsf_shipping_detail_id

    attr_accessor :quantity_still_to_receive

    attr_accessor :from_eservice

    attr_accessor :process_shipper_shipment


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'extension' => :'extension',
        :'description' => :'description',
        :'weight' => :'weight',
        :'component' => :'component',
        :'lot' => :'lot',
        :'email' => :'email',
        :'po_uom' => :'poUom',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'assignable' => :'assignable',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'proof' => :'proof',
        :'job' => :'job',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'state_key' => :'stateKey',
        :'salutation' => :'salutation',
        :'ship_via' => :'shipVia',
        :'zip' => :'zip',
        :'ship_in_name_of' => :'shipInNameOf',
        :'city' => :'city',
        :'ship_bill_to_contact' => :'shipBillToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'item_template' => :'itemTemplate',
        :'quantity' => :'quantity',
        :'customer' => :'customer',
        :'inventory_item' => :'inventoryItem',
        :'quoted_price' => :'quotedPrice',
        :'uom' => :'uom',
        :'cost' => :'cost',
        :'date_time' => :'dateTime',
        :'shipment_type' => :'shipmentType',
        :'contact_number' => :'contactNumber',
        :'tracking_number' => :'trackingNumber',
        :'charge_back_account' => :'chargeBackAccount',
        :'shipper_name' => :'shipperName',
        :'ship_via_note' => :'shipViaNote',
        :'phone' => :'phone',
        :'inventory_location' => :'inventoryLocation',
        :'activity_code' => :'activityCode',
        :'invoice' => :'invoice',
        :'account_number' => :'accountNumber',
        :'assigned_to' => :'assignedTo',
        :'inventory_cost' => :'inventoryCost',
        :'quantity_remaining' => :'quantityRemaining',
        :'scheduled_flag' => :'scheduledFlag',
        :'job_contact' => :'jobContact',
        :'scheduled' => :'scheduled',
        :'use_legacy_print_flow_format' => :'useLegacyPrintFlowFormat',
        :'dsf_product_id' => :'dsfProductID',
        :'qty_picked' => :'qtyPicked',
        :'revision' => :'revision',
        :'vendor_lot_no' => :'vendorLotNo',
        :'lot_expiration_date' => :'lotExpirationDate',
        :'inventory_bin_key' => :'inventoryBinKey',
        :'lot_job_sell_price_per1000' => :'lotJobSellPricePer1000',
        :'carton1_note' => :'carton1Note',
        :'cod_company_check_acceptable' => :'codCompanyCheckAcceptable',
        :'quantity10' => :'quantity10',
        :'process_shipper_id' => :'processShipperId',
        :'bill_of_lading_add' => :'billOfLadingAdd',
        :'print_stream_partial_shipment' => :'printStreamPartialShipment',
        :'package_drop_type' => :'packageDropType',
        :'freight_link_integrated' => :'freightLinkIntegrated',
        :'weight_ounces' => :'weightOunces',
        :'carton1_tracking_number' => :'carton1TrackingNumber',
        :'carton2_skid_count' => :'carton2SkidCount',
        :'carton1_skid_count' => :'carton1SkidCount',
        :'new_item' => :'newItem',
        :'print_stream_final_partial_shipment' => :'printStreamFinalPartialShipment',
        :'xfer_batch' => :'xferBatch',
        :'print_stream_pull_ticket_id' => :'printStreamPullTicketID',
        :'onsite_installation' => :'onsiteInstallation',
        :'charges' => :'charges',
        :'proof_shipment' => :'proofShipment',
        :'note1' => :'note1',
        :'carton1_count' => :'carton1Count',
        :'count1' => :'count1',
        :'ship_to_inventory' => :'shipToInventory',
        :'count2' => :'count2',
        :'third_party_charges' => :'thirdPartyCharges',
        :'saturday' => :'saturday',
        :'count5' => :'count5',
        :'count6' => :'count6',
        :'count3' => :'count3',
        :'count4' => :'count4',
        :'carton3_skid_count' => :'carton3SkidCount',
        :'count9' => :'count9',
        :'count7' => :'count7',
        :'created_from_estimate' => :'createdFromEstimate',
        :'count8' => :'count8',
        :'planned' => :'planned',
        :'selling_price' => :'sellingPrice',
        :'carton3_tracking_number' => :'carton3TrackingNumber',
        :'handling_cost' => :'handlingCost',
        :'auto_created' => :'autoCreated',
        :'inventory_item_type' => :'inventoryItemType',
        :'promise_date_time' => :'promiseDateTime',
        :'freight_classification_number' => :'freightClassificationNumber',
        :'carton3_note' => :'carton3Note',
        :'date_forced' => :'dateForced',
        :'production_shipment' => :'productionShipment',
        :'carton2_count' => :'carton2Count',
        :'child_partial_shipment_count' => :'childPartialShipmentCount',
        :'carton1_quantity' => :'carton1Quantity',
        :'package_drop' => :'packageDrop',
        :'count10' => :'count10',
        :'thickness' => :'thickness',
        :'carton2_note' => :'carton2Note',
        :'collapsed_in_ui' => :'collapsedInUi',
        :'note10' => :'note10',
        :'fob' => :'fob',
        :'quantity1' => :'quantity1',
        :'quantity2' => :'quantity2',
        :'quantity7' => :'quantity7',
        :'planned_quantity' => :'plannedQuantity',
        :'quantity8' => :'quantity8',
        :'quantity9' => :'quantity9',
        :'ship_to_inventory_quantity_received' => :'shipToInventoryQuantityReceived',
        :'quantity3' => :'quantity3',
        :'carton2_quantity' => :'carton2Quantity',
        :'quantity4' => :'quantity4',
        :'quantity5' => :'quantity5',
        :'sent_to_process_shipper' => :'sentToProcessShipper',
        :'quantity6' => :'quantity6',
        :'shipped' => :'shipped',
        :'carton2_tracking_number' => :'carton2TrackingNumber',
        :'quote_shipment' => :'quoteShipment',
        :'note4' => :'note4',
        :'note5' => :'note5',
        :'note2' => :'note2',
        :'forced_account_number' => :'forcedAccountNumber',
        :'note3' => :'note3',
        :'sent_to_dsf' => :'sentToDSF',
        :'note8' => :'note8',
        :'note9' => :'note9',
        :'bill_of_lading' => :'billOfLading',
        :'note6' => :'note6',
        :'note7' => :'note7',
        :'new_inventory_item' => :'newInventoryItem',
        :'cost_distribution' => :'costDistribution',
        :'time_forced' => :'timeForced',
        :'carton3_count' => :'carton3Count',
        :'cod_amount' => :'codAmount',
        :'tracking_link' => :'trackingLink',
        :'tracking_notes' => :'trackingNotes',
        :'carton3_quantity' => :'carton3Quantity',
        :'price_per_pouom' => :'pricePerPOUOM',
        :'dsf_shipping_detail_id' => :'dsfShippingDetailID',
        :'quantity_still_to_receive' => :'quantityStillToReceive',
        :'from_eservice' => :'fromEservice',
        :'process_shipper_shipment' => :'processShipperShipment'
      }
    end
  end
end
