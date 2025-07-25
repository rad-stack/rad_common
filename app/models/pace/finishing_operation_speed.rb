module Pace
  class FinishingOperationSpeed < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :finishing_operation

    attr_accessor :quantity

    attr_accessor :spoilage

    attr_accessor :units_per_hour

    attr_accessor :upto_size_width

    attr_accessor :upto_size_width_display_uom

    attr_accessor :upto_size_length

    attr_accessor :cost_per_m

    attr_accessor :upto_size_length_display_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'finishing_operation' => :'finishingOperation',
        :'quantity' => :'quantity',
        :'spoilage' => :'spoilage',
        :'units_per_hour' => :'unitsPerHour',
        :'upto_size_width' => :'uptoSizeWidth',
        :'upto_size_width_display_uom' => :'uptoSizeWidthDisplayUOM',
        :'upto_size_length' => :'uptoSizeLength',
        :'cost_per_m' => :'costPerM',
        :'upto_size_length_display_uom' => :'uptoSizeLengthDisplayUOM'
      }
    end
  end
end
