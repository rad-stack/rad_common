module Pace
  class JobPartSizeAllowance < Base
    attr_accessor :id

    attr_accessor :source

    attr_accessor :head

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :spine_display_uom

    attr_accessor :size_allowance_type

    attr_accessor :face_allowance_expression

    attr_accessor :odd_panel_spine_size

    attr_accessor :head_allowance_expression

    attr_accessor :calculated_spine

    attr_accessor :calculated_foot

    attr_accessor :odd_panel_width_size_display_uom

    attr_accessor :odd_panel_spine_size_display_uom

    attr_accessor :foot_display_uom

    attr_accessor :foot

    attr_accessor :calculated_head

    attr_accessor :odd_panel_width_size

    attr_accessor :calculated_face

    attr_accessor :spine_width

    attr_accessor :spine

    attr_accessor :num_odd_panels_spine

    attr_accessor :face_display_uom

    attr_accessor :foot_allowance_expression

    attr_accessor :head_display_uom

    attr_accessor :face

    attr_accessor :num_odd_panels_width

    attr_accessor :spine_allowance_expression

    attr_accessor :spine_width_display_uom


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'source' => :'source',
        :'head' => :'head',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'spine_display_uom' => :'spineDisplayUOM',
        :'size_allowance_type' => :'sizeAllowanceType',
        :'face_allowance_expression' => :'faceAllowanceExpression',
        :'odd_panel_spine_size' => :'oddPanelSpineSize',
        :'head_allowance_expression' => :'headAllowanceExpression',
        :'calculated_spine' => :'calculatedSpine',
        :'calculated_foot' => :'calculatedFoot',
        :'odd_panel_width_size_display_uom' => :'oddPanelWidthSizeDisplayUOM',
        :'odd_panel_spine_size_display_uom' => :'oddPanelSpineSizeDisplayUOM',
        :'foot_display_uom' => :'footDisplayUOM',
        :'foot' => :'foot',
        :'calculated_head' => :'calculatedHead',
        :'odd_panel_width_size' => :'oddPanelWidthSize',
        :'calculated_face' => :'calculatedFace',
        :'spine_width' => :'spineWidth',
        :'spine' => :'spine',
        :'num_odd_panels_spine' => :'numOddPanelsSpine',
        :'face_display_uom' => :'faceDisplayUOM',
        :'foot_allowance_expression' => :'footAllowanceExpression',
        :'head_display_uom' => :'headDisplayUOM',
        :'face' => :'face',
        :'num_odd_panels_width' => :'numOddPanelsWidth',
        :'spine_allowance_expression' => :'spineAllowanceExpression',
        :'spine_width_display_uom' => :'spineWidthDisplayUOM'
      }
    end
  end
end
