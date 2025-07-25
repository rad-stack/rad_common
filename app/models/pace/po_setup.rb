module Pace
  class POSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_contact

    attr_accessor :lead_time

    attr_accessor :gl_account

    attr_accessor :allow_duplicate_po_numbers

    attr_accessor :po_number6

    attr_accessor :po_number7

    attr_accessor :po_number4

    attr_accessor :po_number5

    attr_accessor :po_number2

    attr_accessor :po_number3

    attr_accessor :po_number1

    attr_accessor :auto_approve_inventory_transaction

    attr_accessor :auto_create_job_material_lines

    attr_accessor :enable_purchasing_limits

    attr_accessor :uom

    attr_accessor :status_id

    attr_accessor :order_qty

    attr_accessor :default_disc

    attr_accessor :calculate_date_required_on_auto_create

    attr_accessor :po_number8

    attr_accessor :po_number9

    attr_accessor :auto_close_purchase_orders

    attr_accessor :auto_create_job_part_outside_purch_lines

    attr_accessor :allow_multiple_ship_to

    attr_accessor :update_inventory_cost_from_bill

    attr_accessor :default_quantity_to_receive

    attr_accessor :auto_create_inventory_item_lines

    attr_accessor :enable_track_revisions

    attr_accessor :po_number_prefix1

    attr_accessor :display_paper_info

    attr_accessor :po_number_prefix4

    attr_accessor :po_number_prefix5

    attr_accessor :po_number_prefix2

    attr_accessor :po_number_prefix3

    attr_accessor :po_number_prefix8

    attr_accessor :default_activity_code

    attr_accessor :default_line_type

    attr_accessor :po_number_prefix9

    attr_accessor :po_number_prefix6

    attr_accessor :po_number_prefix7

    attr_accessor :tax_to_job_cost

    attr_accessor :interface_ap

    attr_accessor :include_setup

    attr_accessor :integrate_with_scheduling

    attr_accessor :show_vendor_item_on_auto_create

    attr_accessor :interface_jc


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_contact' => :'defaultContact',
        :'lead_time' => :'leadTime',
        :'gl_account' => :'glAccount',
        :'allow_duplicate_po_numbers' => :'allowDuplicatePONumbers',
        :'po_number6' => :'poNumber6',
        :'po_number7' => :'poNumber7',
        :'po_number4' => :'poNumber4',
        :'po_number5' => :'poNumber5',
        :'po_number2' => :'poNumber2',
        :'po_number3' => :'poNumber3',
        :'po_number1' => :'poNumber1',
        :'auto_approve_inventory_transaction' => :'autoApproveInventoryTransaction',
        :'auto_create_job_material_lines' => :'autoCreateJobMaterialLines',
        :'enable_purchasing_limits' => :'enablePurchasingLimits',
        :'uom' => :'uom',
        :'status_id' => :'statusID',
        :'order_qty' => :'orderQty',
        :'default_disc' => :'defaultDisc',
        :'calculate_date_required_on_auto_create' => :'calculateDateRequiredOnAutoCreate',
        :'po_number8' => :'poNumber8',
        :'po_number9' => :'poNumber9',
        :'auto_close_purchase_orders' => :'autoClosePurchaseOrders',
        :'auto_create_job_part_outside_purch_lines' => :'autoCreateJobPartOutsidePurchLines',
        :'allow_multiple_ship_to' => :'allowMultipleShipTo',
        :'update_inventory_cost_from_bill' => :'updateInventoryCostFromBill',
        :'default_quantity_to_receive' => :'defaultQuantityToReceive',
        :'auto_create_inventory_item_lines' => :'autoCreateInventoryItemLines',
        :'enable_track_revisions' => :'enableTrackRevisions',
        :'po_number_prefix1' => :'poNumberPrefix1',
        :'display_paper_info' => :'displayPaperInfo',
        :'po_number_prefix4' => :'poNumberPrefix4',
        :'po_number_prefix5' => :'poNumberPrefix5',
        :'po_number_prefix2' => :'poNumberPrefix2',
        :'po_number_prefix3' => :'poNumberPrefix3',
        :'po_number_prefix8' => :'poNumberPrefix8',
        :'default_activity_code' => :'defaultActivityCode',
        :'default_line_type' => :'defaultLineType',
        :'po_number_prefix9' => :'poNumberPrefix9',
        :'po_number_prefix6' => :'poNumberPrefix6',
        :'po_number_prefix7' => :'poNumberPrefix7',
        :'tax_to_job_cost' => :'taxToJobCost',
        :'interface_ap' => :'interfaceAP',
        :'include_setup' => :'includeSetup',
        :'integrate_with_scheduling' => :'integrateWithScheduling',
        :'show_vendor_item_on_auto_create' => :'showVendorItemOnAutoCreate',
        :'interface_jc' => :'interfaceJC'
      }
    end
  end
end
