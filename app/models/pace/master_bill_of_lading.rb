module Pace
  class MasterBillOfLading < Base
    attr_accessor :id

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ship_bill_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :tracking_number

    attr_accessor :mbol_manufacturing_location_change_flag

    attr_accessor :number_joined_bols

    attr_accessor :master_bol_ship_to_contact

    attr_accessor :ship_date_time

    attr_accessor :mbol_ship_bill_to_contact_change_flag

    attr_accessor :mbol_ship_time_change_flag

    attr_accessor :mbol_status_change_flag

    attr_accessor :confirm_ship_date

    attr_accessor :mbol_ship_date_change_flag

    attr_accessor :ship_via_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ship_bill_to_contact' => :'shipBillToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'tracking_number' => :'trackingNumber',
        :'mbol_manufacturing_location_change_flag' => :'mbolManufacturingLocationChangeFlag',
        :'number_joined_bols' => :'numberJoinedBOLs',
        :'master_bol_ship_to_contact' => :'masterBOLShipToContact',
        :'ship_date_time' => :'shipDateTime',
        :'mbol_ship_bill_to_contact_change_flag' => :'mbolShipBillToContactChangeFlag',
        :'mbol_ship_time_change_flag' => :'mbolShipTimeChangeFlag',
        :'mbol_status_change_flag' => :'mbolStatusChangeFlag',
        :'confirm_ship_date' => :'confirmShipDate',
        :'mbol_ship_date_change_flag' => :'mbolShipDateChangeFlag',
        :'ship_via_id' => :'shipViaID'
      }
    end
  end
end
