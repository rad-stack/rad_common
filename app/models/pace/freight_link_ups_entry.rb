module Pace
  class FreightLinkUPSEntry < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :error_message

    attr_accessor :weight

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :city

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :customer

    attr_accessor :cost

    attr_accessor :shipment_type

    attr_accessor :tracking_number

    attr_accessor :phone

    attr_accessor :company_name

    attr_accessor :saturday

    attr_accessor :processed

    attr_accessor :billing_type

    attr_accessor :shipment_id

    attr_accessor :reviewed

    attr_accessor :master_tracking_number

    attr_accessor :carton_count

    attr_accessor :third_pty_acct_num

    attr_accessor :void

    attr_accessor :edited

    attr_accessor :contact_name

    attr_accessor :ship_date

    attr_accessor :residential

    attr_accessor :job_and_part

    attr_accessor :total_shipment_charge

    attr_accessor :ship_method

    attr_accessor :shipper_amount

    attr_accessor :consignee_amount

    attr_accessor :third_pty_amount

    attr_accessor :qty_per_carton

    attr_accessor :postal_code

    attr_accessor :consignee_account

    attr_accessor :third_pty_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'error_message' => :'errorMessage',
        :'weight' => :'weight',
        :'email' => :'email',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'city' => :'city',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'customer' => :'customer',
        :'cost' => :'cost',
        :'shipment_type' => :'shipmentType',
        :'tracking_number' => :'trackingNumber',
        :'phone' => :'phone',
        :'company_name' => :'companyName',
        :'saturday' => :'saturday',
        :'processed' => :'processed',
        :'billing_type' => :'billingType',
        :'shipment_id' => :'shipmentID',
        :'reviewed' => :'reviewed',
        :'master_tracking_number' => :'masterTrackingNumber',
        :'carton_count' => :'cartonCount',
        :'third_pty_acct_num' => :'thirdPtyAcctNum',
        :'void' => :'void',
        :'edited' => :'edited',
        :'contact_name' => :'contactName',
        :'ship_date' => :'shipDate',
        :'residential' => :'residential',
        :'job_and_part' => :'jobAndPart',
        :'total_shipment_charge' => :'totalShipmentCharge',
        :'ship_method' => :'shipMethod',
        :'shipper_amount' => :'shipperAmount',
        :'consignee_amount' => :'consigneeAmount',
        :'third_pty_amount' => :'thirdPtyAmount',
        :'qty_per_carton' => :'qtyPerCarton',
        :'postal_code' => :'postalCode',
        :'consignee_account' => :'consigneeAccount',
        :'third_pty_name' => :'thirdPtyName'
      }
    end
  end
end
