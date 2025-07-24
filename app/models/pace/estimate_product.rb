module Pace
  class EstimateProduct < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :sequence

    attr_accessor :manufacturing_location

    attr_accessor :wrap_rear_window

    attr_accessor :second_surface

    attr_accessor :lookup_url

    attr_accessor :material_tags

    attr_accessor :reference1

    attr_accessor :composite_product_pages

    attr_accessor :reference2

    attr_accessor :notes5

    attr_accessor :vehicle_year

    attr_accessor :notes4

    attr_accessor :notes3

    attr_accessor :additional_description

    attr_accessor :notes2

    attr_accessor :notes1

    attr_accessor :single_web_delivery

    attr_accessor :estimate

    attr_accessor :vehicle_model

    attr_accessor :available_manufacturing_locations

    attr_accessor :user_interface_set

    attr_accessor :composite_product

    attr_accessor :vehicle_make

    attr_accessor :preferred_binding_type

    attr_accessor :total_pages

    attr_accessor :wrap_side_window

    attr_accessor :wrap_style


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'sequence' => :'sequence',
        :'manufacturing_location' => :'manufacturingLocation',
        :'wrap_rear_window' => :'wrapRearWindow',
        :'second_surface' => :'secondSurface',
        :'lookup_url' => :'lookupURL',
        :'material_tags' => :'materialTags',
        :'reference1' => :'reference1',
        :'composite_product_pages' => :'compositeProductPages',
        :'reference2' => :'reference2',
        :'notes5' => :'notes5',
        :'vehicle_year' => :'vehicleYear',
        :'notes4' => :'notes4',
        :'notes3' => :'notes3',
        :'additional_description' => :'additionalDescription',
        :'notes2' => :'notes2',
        :'notes1' => :'notes1',
        :'single_web_delivery' => :'singleWebDelivery',
        :'estimate' => :'estimate',
        :'vehicle_model' => :'vehicleModel',
        :'available_manufacturing_locations' => :'availableManufacturingLocations',
        :'user_interface_set' => :'userInterfaceSet',
        :'composite_product' => :'compositeProduct',
        :'vehicle_make' => :'vehicleMake',
        :'preferred_binding_type' => :'preferredBindingType',
        :'total_pages' => :'totalPages',
        :'wrap_side_window' => :'wrapSideWindow',
        :'wrap_style' => :'wrapStyle'
      }
    end
  end
end
