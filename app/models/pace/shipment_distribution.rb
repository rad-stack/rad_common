module Pace
  class ShipmentDistribution < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :content

    attr_accessor :country

    attr_accessor :extension

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part_press_form

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :state_key

    attr_accessor :ship_via

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :ship_to_contact

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :quantity

    attr_accessor :note

    attr_accessor :phone

    attr_accessor :job_material

    attr_accessor :quantity_invoiced

    attr_accessor :job_product

    attr_accessor :quantity_to_be_invoiced

    attr_accessor :content_quantity_ordered

    attr_accessor :total_quantity

    attr_accessor :content_description

    attr_accessor :job_component

    attr_accessor :job_part_item

    attr_accessor :quantity_remaining

    attr_accessor :date_entered

    attr_accessor :delivered

    attr_accessor :carton_content

    attr_accessor :add_to_shipment


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'content' => :'content',
        :'country' => :'country',
        :'extension' => :'extension',
        :'email' => :'email',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part_press_form' => :'jobPartPressForm',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'state_key' => :'stateKey',
        :'ship_via' => :'shipVia',
        :'zip' => :'zip',
        :'city' => :'city',
        :'ship_to_contact' => :'shipToContact',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'quantity' => :'quantity',
        :'note' => :'note',
        :'phone' => :'phone',
        :'job_material' => :'jobMaterial',
        :'quantity_invoiced' => :'quantityInvoiced',
        :'job_product' => :'jobProduct',
        :'quantity_to_be_invoiced' => :'quantityToBeInvoiced',
        :'content_quantity_ordered' => :'contentQuantityOrdered',
        :'total_quantity' => :'totalQuantity',
        :'content_description' => :'contentDescription',
        :'job_component' => :'jobComponent',
        :'job_part_item' => :'jobPartItem',
        :'quantity_remaining' => :'quantityRemaining',
        :'date_entered' => :'dateEntered',
        :'delivered' => :'delivered',
        :'carton_content' => :'cartonContent',
        :'add_to_shipment' => :'addToShipment'
      }
    end
  end
end
