module Pace
  class BillOfLading < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :bill_to_contact

    attr_accessor :ship_via

    attr_accessor :manufacturing_location

    attr_accessor :cost

    attr_accessor :tracking_number

    attr_accessor :ship_date_time

    attr_accessor :confirm_ship_date

    attr_accessor :process_shipper_id

    attr_accessor :fob

    attr_accessor :sent_to_process_shipper

    attr_accessor :bill_of_lading_type

    attr_accessor :number_shipments_on_bol

    attr_accessor :stop_number

    attr_accessor :joined_master_bill_of_lading


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
        :'bill_to_contact' => :'billToContact',
        :'ship_via' => :'shipVia',
        :'manufacturing_location' => :'manufacturingLocation',
        :'cost' => :'cost',
        :'tracking_number' => :'trackingNumber',
        :'ship_date_time' => :'shipDateTime',
        :'confirm_ship_date' => :'confirmShipDate',
        :'process_shipper_id' => :'processShipperId',
        :'fob' => :'fob',
        :'sent_to_process_shipper' => :'sentToProcessShipper',
        :'bill_of_lading_type' => :'billOfLadingType',
        :'number_shipments_on_bol' => :'numberShipmentsOnBOL',
        :'stop_number' => :'stopNumber',
        :'joined_master_bill_of_lading' => :'joinedMasterBillOfLading'
      }
    end
  end
end
