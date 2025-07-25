module Pace
  class ContentFileContour < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :content_file

    attr_accessor :contour_perimeter

    attr_accessor :contour_perimeter_uom

    attr_accessor :contour_height_uom

    attr_accessor :contour_width

    attr_accessor :preview

    attr_accessor :metrix_path

    attr_accessor :measurement_unit

    attr_accessor :outline

    attr_accessor :contour_height

    attr_accessor :contour_width_uom

    attr_accessor :metrix_cutter_operation


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'content_file' => :'contentFile',
        :'contour_perimeter' => :'contourPerimeter',
        :'contour_perimeter_uom' => :'contourPerimeterUOM',
        :'contour_height_uom' => :'contourHeightUOM',
        :'contour_width' => :'contourWidth',
        :'preview' => :'preview',
        :'metrix_path' => :'metrixPath',
        :'measurement_unit' => :'measurementUnit',
        :'outline' => :'outline',
        :'contour_height' => :'contourHeight',
        :'contour_width_uom' => :'contourWidthUOM',
        :'metrix_cutter_operation' => :'metrixCutterOperation'
      }
    end
  end
end
