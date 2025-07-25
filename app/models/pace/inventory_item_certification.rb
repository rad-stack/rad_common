module Pace
  class InventoryItemCertification < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :certification_authority

    attr_accessor :certification_level

    attr_accessor :inventory_item

    attr_accessor :certificate_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'certification_authority' => :'certificationAuthority',
        :'certification_level' => :'certificationLevel',
        :'inventory_item' => :'inventoryItem',
        :'certificate_number' => :'certificateNumber'
      }
    end
  end
end
