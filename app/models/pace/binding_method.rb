module Pace
  class BindingMethod < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_locations

    attr_accessor :alt_description

    attr_accessor :allow_empty

    attr_accessor :jdf_finishing_category


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
        :'manufacturing_locations' => :'manufacturingLocations',
        :'alt_description' => :'altDescription',
        :'allow_empty' => :'allowEmpty',
        :'jdf_finishing_category' => :'jdfFinishingCategory'
      }
    end
  end
end
