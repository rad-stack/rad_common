module Pace
  class EstimatePressMixedMedia < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :colors_side1

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_press

    attr_accessor :num_up

    attr_accessor :colors_side2

    attr_accessor :page_range

    attr_accessor :run_size_height

    attr_accessor :non_printed

    attr_accessor :run_size_width

    attr_accessor :duplex_mode

    attr_accessor :image_shift_y_axis

    attr_accessor :run_size_width_display_uom

    attr_accessor :binder_insert_repeat

    attr_accessor :sheet_count

    attr_accessor :page_range_display

    attr_accessor :num_blanks

    attr_accessor :orientation

    attr_accessor :page_count

    attr_accessor :run_size_height_display_uom

    attr_accessor :image_shift_x_axis

    attr_accessor :run_insert

    attr_accessor :tabs_only

    attr_accessor :run_insert_mixed_media

    attr_accessor :estimate_paper


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'colors_side1' => :'colorsSide1',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_press' => :'estimatePress',
        :'num_up' => :'numUp',
        :'colors_side2' => :'colorsSide2',
        :'page_range' => :'pageRange',
        :'run_size_height' => :'runSizeHeight',
        :'non_printed' => :'nonPrinted',
        :'run_size_width' => :'runSizeWidth',
        :'duplex_mode' => :'duplexMode',
        :'image_shift_y_axis' => :'imageShiftYAxis',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'binder_insert_repeat' => :'binderInsertRepeat',
        :'sheet_count' => :'sheetCount',
        :'page_range_display' => :'pageRangeDisplay',
        :'num_blanks' => :'numBlanks',
        :'orientation' => :'orientation',
        :'page_count' => :'pageCount',
        :'run_size_height_display_uom' => :'runSizeHeightDisplayUOM',
        :'image_shift_x_axis' => :'imageShiftXAxis',
        :'run_insert' => :'runInsert',
        :'tabs_only' => :'tabsOnly',
        :'run_insert_mixed_media' => :'runInsertMixedMedia',
        :'estimate_paper' => :'estimatePaper'
      }
    end
  end
end
