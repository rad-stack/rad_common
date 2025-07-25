module Pace
  class StandardPaperType < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :plant_manager_id

    attr_accessor :paper_type

    attr_accessor :area

    attr_accessor :basic_size_width_display_uom

    attr_accessor :area_uom

    attr_accessor :basic_size_width_calculator

    attr_accessor :basis_sheets_calculator

    attr_accessor :basic_size_width_calculator_display_uom

    attr_accessor :basic_size_length_calculator_display_uom

    attr_accessor :basic_size_length_calculator

    attr_accessor :basic_size_length_display_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'plant_manager_id' => :'plantManagerId',
        :'paper_type' => :'paperType',
        :'area' => :'area',
        :'basic_size_width_display_uom' => :'basicSizeWidthDisplayUOM',
        :'area_uom' => :'areaUOM',
        :'basic_size_width_calculator' => :'basicSizeWidthCalculator',
        :'basis_sheets_calculator' => :'basisSheetsCalculator',
        :'basic_size_width_calculator_display_uom' => :'basicSizeWidthCalculatorDisplayUOM',
        :'basic_size_length_calculator_display_uom' => :'basicSizeLengthCalculatorDisplayUOM',
        :'basic_size_length_calculator' => :'basicSizeLengthCalculator',
        :'basic_size_length_display_uom' => :'basicSizeLengthDisplayUOM'
      }
    end
  end
end
