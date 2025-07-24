module Pace
  class PaperWeight < Base
    attr_accessor :id

    attr_accessor :weight

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_locations

    attr_accessor :paper_type

    attr_accessor :thickness

    attr_accessor :thickness_uom

    attr_accessor :folder_speed_adjustment

    attr_accessor :quantity_uom

    attr_accessor :router_speed_adjustment

    attr_accessor :router_setup_adjustment

    attr_accessor :router_spoilage_adjustment

    attr_accessor :cutter_speed_adjustment

    attr_accessor :score_required_to_fold

    attr_accessor :press_speed_adjustment

    attr_accessor :folder_spoilage_adjustment

    attr_accessor :weight_uom

    attr_accessor :press_spoilage_adjustment


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'weight' => :'weight',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'paper_type' => :'paperType',
        :'thickness' => :'thickness',
        :'thickness_uom' => :'thicknessUOM',
        :'folder_speed_adjustment' => :'folderSpeedAdjustment',
        :'quantity_uom' => :'quantityUOM',
        :'router_speed_adjustment' => :'routerSpeedAdjustment',
        :'router_setup_adjustment' => :'routerSetupAdjustment',
        :'router_spoilage_adjustment' => :'routerSpoilageAdjustment',
        :'cutter_speed_adjustment' => :'cutterSpeedAdjustment',
        :'score_required_to_fold' => :'scoreRequiredToFold',
        :'press_speed_adjustment' => :'pressSpeedAdjustment',
        :'folder_spoilage_adjustment' => :'folderSpoilageAdjustment',
        :'weight_uom' => :'weightUOM',
        :'press_spoilage_adjustment' => :'pressSpoilageAdjustment'
      }
    end
  end
end
