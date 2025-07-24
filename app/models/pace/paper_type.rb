module Pace
  class PaperType < Base
    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :plant_manager_id

    attr_accessor :activity_code

    attr_accessor :make_ready_activity_code

    attr_accessor :alt_description

    attr_accessor :standard_paper_type

    attr_accessor :press_type

    attr_accessor :partial_sheet_costing

    attr_accessor :coatable

    attr_accessor :back_coating

    attr_accessor :front_and_back_same

    attr_accessor :stock_may_be_cut_down

    attr_accessor :allow_perfecting

    attr_accessor :front_coating

    attr_accessor :recycled_percentage

    attr_accessor :substrate_type

    attr_accessor :texture

    attr_accessor :weight_type

    attr_accessor :paper_ink_mileage


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'plant_manager_id' => :'plantManagerId',
        :'activity_code' => :'activityCode',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'alt_description' => :'altDescription',
        :'standard_paper_type' => :'standardPaperType',
        :'press_type' => :'pressType',
        :'partial_sheet_costing' => :'partialSheetCosting',
        :'coatable' => :'coatable',
        :'back_coating' => :'backCoating',
        :'front_and_back_same' => :'frontAndBackSame',
        :'stock_may_be_cut_down' => :'stockMayBeCutDown',
        :'allow_perfecting' => :'allowPerfecting',
        :'front_coating' => :'frontCoating',
        :'recycled_percentage' => :'recycledPercentage',
        :'substrate_type' => :'substrateType',
        :'texture' => :'texture',
        :'weight_type' => :'weightType',
        :'paper_ink_mileage' => :'paperInkMileage'
      }
    end
  end
end
