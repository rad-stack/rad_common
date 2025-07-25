module Pace
  class SizeAllowanceType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :size_allowance_type

    attr_accessor :face_allowance_expression

    attr_accessor :odd_panel_spine_size

    attr_accessor :head_allowance_expression

    attr_accessor :odd_panel_width_size_display_uom

    attr_accessor :odd_panel_spine_size_display_uom

    attr_accessor :odd_panel_width_size

    attr_accessor :spine_width

    attr_accessor :num_odd_panels_spine

    attr_accessor :foot_allowance_expression

    attr_accessor :num_odd_panels_width

    attr_accessor :spine_allowance_expression

    attr_accessor :spine_width_display_uom

    attr_accessor :foot_default_value_display_uom

    attr_accessor :specify_foot

    attr_accessor :face_default_value

    attr_accessor :specify_head

    attr_accessor :face_default_value_display_uom

    attr_accessor :specify_spine

    attr_accessor :specify_face

    attr_accessor :spine_default_value_display_uom

    attr_accessor :head_default_value_display_uom

    attr_accessor :spine_default_value

    attr_accessor :foot_default_value

    attr_accessor :head_default_value


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
        :'system_generated' => :'systemGenerated',
        :'size_allowance_type' => :'sizeAllowanceType',
        :'face_allowance_expression' => :'faceAllowanceExpression',
        :'odd_panel_spine_size' => :'oddPanelSpineSize',
        :'head_allowance_expression' => :'headAllowanceExpression',
        :'odd_panel_width_size_display_uom' => :'oddPanelWidthSizeDisplayUOM',
        :'odd_panel_spine_size_display_uom' => :'oddPanelSpineSizeDisplayUOM',
        :'odd_panel_width_size' => :'oddPanelWidthSize',
        :'spine_width' => :'spineWidth',
        :'num_odd_panels_spine' => :'numOddPanelsSpine',
        :'foot_allowance_expression' => :'footAllowanceExpression',
        :'num_odd_panels_width' => :'numOddPanelsWidth',
        :'spine_allowance_expression' => :'spineAllowanceExpression',
        :'spine_width_display_uom' => :'spineWidthDisplayUOM',
        :'foot_default_value_display_uom' => :'footDefaultValueDisplayUOM',
        :'specify_foot' => :'specifyFoot',
        :'face_default_value' => :'faceDefaultValue',
        :'specify_head' => :'specifyHead',
        :'face_default_value_display_uom' => :'faceDefaultValueDisplayUOM',
        :'specify_spine' => :'specifySpine',
        :'specify_face' => :'specifyFace',
        :'spine_default_value_display_uom' => :'spineDefaultValueDisplayUOM',
        :'head_default_value_display_uom' => :'headDefaultValueDisplayUOM',
        :'spine_default_value' => :'spineDefaultValue',
        :'foot_default_value' => :'footDefaultValue',
        :'head_default_value' => :'headDefaultValue'
      }
    end
  end
end
