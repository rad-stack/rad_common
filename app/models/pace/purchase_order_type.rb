module Pace
  class PurchaseOrderType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :use_manufacturing_location_prefix

    attr_accessor :po_number_prefix

    attr_accessor :auto_number_only

    attr_accessor :po_number_sequence


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'use_manufacturing_location_prefix' => :'useManufacturingLocationPrefix',
        :'po_number_prefix' => :'poNumberPrefix',
        :'auto_number_only' => :'autoNumberOnly',
        :'po_number_sequence' => :'poNumberSequence'
      }
    end
  end
end
