module Pace
  class JobPartImpositionAllowance < Base
    attr_accessor :id

    attr_accessor :position

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :bleed_right

    attr_accessor :page_number

    attr_accessor :bleed_left

    attr_accessor :bleed_bottom

    attr_accessor :bleed_right_display_uom

    attr_accessor :bleed_top_display_uom

    attr_accessor :bleed_top

    attr_accessor :imposition_size_allowance_type

    attr_accessor :bleed_bottom_display_uom

    attr_accessor :bleed_left_display_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'position' => :'position',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'bleed_right' => :'bleedRight',
        :'page_number' => :'pageNumber',
        :'bleed_left' => :'bleedLeft',
        :'bleed_bottom' => :'bleedBottom',
        :'bleed_right_display_uom' => :'bleedRightDisplayUOM',
        :'bleed_top_display_uom' => :'bleedTopDisplayUOM',
        :'bleed_top' => :'bleedTop',
        :'imposition_size_allowance_type' => :'impositionSizeAllowanceType',
        :'bleed_bottom_display_uom' => :'bleedBottomDisplayUOM',
        :'bleed_left_display_uom' => :'bleedLeftDisplayUOM'
      }
    end
  end
end
