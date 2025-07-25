module Pace
  class EstimateRequestProduct < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :system_generated

    attr_accessor :sequence

    attr_accessor :manufacturing_location

    attr_accessor :estimate_product

    attr_accessor :production_type

    attr_accessor :wrap_rear_window

    attr_accessor :second_surface

    attr_accessor :lookup_url

    attr_accessor :material_tags

    attr_accessor :notes5

    attr_accessor :vehicle_year

    attr_accessor :notes4

    attr_accessor :notes3

    attr_accessor :additional_description

    attr_accessor :notes2

    attr_accessor :notes1

    attr_accessor :single_web_delivery

    attr_accessor :vehicle_model

    attr_accessor :user_interface_set

    attr_accessor :composite_product

    attr_accessor :vehicle_make

    attr_accessor :preferred_binding_type

    attr_accessor :total_pages

    attr_accessor :wrap_side_window

    attr_accessor :wrap_style

    attr_accessor :total_parts

    attr_accessor :product_source

    attr_accessor :composite_pages

    attr_accessor :estimate_request

    attr_accessor :questionnaire_product

    attr_accessor :product_binding_type


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
        :'category' => :'category',
        :'system_generated' => :'systemGenerated',
        :'sequence' => :'sequence',
        :'manufacturing_location' => :'manufacturingLocation',
        :'estimate_product' => :'estimateProduct',
        :'production_type' => :'productionType',
        :'wrap_rear_window' => :'wrapRearWindow',
        :'second_surface' => :'secondSurface',
        :'lookup_url' => :'lookupURL',
        :'material_tags' => :'materialTags',
        :'notes5' => :'notes5',
        :'vehicle_year' => :'vehicleYear',
        :'notes4' => :'notes4',
        :'notes3' => :'notes3',
        :'additional_description' => :'additionalDescription',
        :'notes2' => :'notes2',
        :'notes1' => :'notes1',
        :'single_web_delivery' => :'singleWebDelivery',
        :'vehicle_model' => :'vehicleModel',
        :'user_interface_set' => :'userInterfaceSet',
        :'composite_product' => :'compositeProduct',
        :'vehicle_make' => :'vehicleMake',
        :'preferred_binding_type' => :'preferredBindingType',
        :'total_pages' => :'totalPages',
        :'wrap_side_window' => :'wrapSideWindow',
        :'wrap_style' => :'wrapStyle',
        :'total_parts' => :'totalParts',
        :'product_source' => :'productSource',
        :'composite_pages' => :'compositePages',
        :'estimate_request' => :'estimateRequest',
        :'questionnaire_product' => :'questionnaireProduct',
        :'product_binding_type' => :'productBindingType'
      }
    end
  end
end
