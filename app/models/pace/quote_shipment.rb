module Pace
  class QuoteShipment < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :extension

    attr_accessor :weight

    attr_accessor :distribution

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :state_key

    attr_accessor :salutation

    attr_accessor :ship_via

    attr_accessor :zip

    attr_accessor :ship_in_name_of

    attr_accessor :city

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :quantity

    attr_accessor :quoted_price

    attr_accessor :cost

    attr_accessor :date_time

    attr_accessor :lock_distribution

    attr_accessor :lock_quoted_price

    attr_accessor :shipment_type

    attr_accessor :quote

    attr_accessor :cost_forced

    attr_accessor :contact_number

    attr_accessor :fax

    attr_accessor :tracking_number

    attr_accessor :charge_back_account

    attr_accessor :shipper_name

    attr_accessor :ship_via_note

    attr_accessor :phone


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'extension' => :'extension',
        :'weight' => :'weight',
        :'distribution' => :'distribution',
        :'email' => :'email',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'state_key' => :'stateKey',
        :'salutation' => :'salutation',
        :'ship_via' => :'shipVia',
        :'zip' => :'zip',
        :'ship_in_name_of' => :'shipInNameOf',
        :'city' => :'city',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'quantity' => :'quantity',
        :'quoted_price' => :'quotedPrice',
        :'cost' => :'cost',
        :'date_time' => :'dateTime',
        :'lock_distribution' => :'lockDistribution',
        :'lock_quoted_price' => :'lockQuotedPrice',
        :'shipment_type' => :'shipmentType',
        :'quote' => :'quote',
        :'cost_forced' => :'costForced',
        :'contact_number' => :'contactNumber',
        :'fax' => :'fax',
        :'tracking_number' => :'trackingNumber',
        :'charge_back_account' => :'chargeBackAccount',
        :'shipper_name' => :'shipperName',
        :'ship_via_note' => :'shipViaNote',
        :'phone' => :'phone'
      }
    end
  end
end
