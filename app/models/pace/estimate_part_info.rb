module Pace
  class EstimatePartInfo < Base
    attr_accessor :estimate_id

    attr_accessor :composite_product

    attr_accessor :composite_pages

    attr_accessor :product

    attr_accessor :part_description

    attr_accessor :estimate_product

    attr_accessor :fold_pattern

    attr_accessor :tile_product

    attr_accessor :seam_direction

    attr_accessor :gangable

    attr_accessor :each_of

    attr_accessor :num_plies

    attr_accessor :difficulty

    attr_accessor :bleeds_along

    attr_accessor :bleeds_across

    attr_accessor :grain_specifications

    attr_accessor :colors_side1

    attr_accessor :colors_side2

    attr_accessor :total_colors

    attr_accessor :ink_default

    attr_accessor :ink_type

    attr_accessor :ink_coverage_front

    attr_accessor :ink_coverage_front_specify

    attr_accessor :ink_coverage_back

    attr_accessor :ink_coverage_back_specify

    attr_accessor :press_ink_type

    attr_accessor :coating

    attr_accessor :coating_sides

    attr_accessor :coating_dry

    attr_accessor :varnish

    attr_accessor :varnish_sides

    attr_accessor :varnish_dry

    attr_accessor :binding_method

    attr_accessor :shipping_workflow

    attr_accessor :press_event_workflow

    attr_accessor :prepress_workflow

    attr_accessor :speed_factor

    attr_accessor :production_type

    attr_accessor :final_size_h

    attr_accessor :final_size_w

    attr_accessor :price_list

    attr_accessor :item_discount_percent

    attr_accessor :product_type

    attr_accessor :virtual_printer

    attr_accessor :include_mailing

    attr_accessor :price_level

    attr_accessor :sales_category

    attr_accessor :quantity1

    attr_accessor :quantity1_desc

    attr_accessor :quantity2

    attr_accessor :quantity2_desc

    attr_accessor :quantity3

    attr_accessor :quantity3_desc

    attr_accessor :quantity4

    attr_accessor :quantity4_desc

    attr_accessor :quantity5

    attr_accessor :quantity5_desc

    attr_accessor :quantity6

    attr_accessor :quantity6_desc

    attr_accessor :quantity7

    attr_accessor :quantity7_desc

    attr_accessor :quantity8

    attr_accessor :quantity8_desc

    attr_accessor :quantity9

    attr_accessor :quantity9_desc

    attr_accessor :quantity10

    attr_accessor :quantity10_desc

    attr_accessor :commission_rate

    attr_accessor :gripper_color_bar

    attr_accessor :combo_percent

    attr_accessor :estimate_press_info

    attr_accessor :estimate_paper_info


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'estimate_id' => :'estimateID',
        :'composite_product' => :'compositeProduct',
        :'composite_pages' => :'compositePages',
        :'product' => :'product',
        :'part_description' => :'partDescription',
        :'estimate_product' => :'estimateProduct',
        :'fold_pattern' => :'foldPattern',
        :'tile_product' => :'tileProduct',
        :'seam_direction' => :'seamDirection',
        :'gangable' => :'gangable',
        :'each_of' => :'eachOf',
        :'num_plies' => :'numPlies',
        :'difficulty' => :'difficulty',
        :'bleeds_along' => :'bleedsAlong',
        :'bleeds_across' => :'bleedsAcross',
        :'grain_specifications' => :'grainSpecifications',
        :'colors_side1' => :'colorsSide1',
        :'colors_side2' => :'colorsSide2',
        :'total_colors' => :'totalColors',
        :'ink_default' => :'inkDefault',
        :'ink_type' => :'inkType',
        :'ink_coverage_front' => :'inkCoverageFront',
        :'ink_coverage_front_specify' => :'inkCoverageFrontSpecify',
        :'ink_coverage_back' => :'inkCoverageBack',
        :'ink_coverage_back_specify' => :'inkCoverageBackSpecify',
        :'press_ink_type' => :'pressInkType',
        :'coating' => :'coating',
        :'coating_sides' => :'coatingSides',
        :'coating_dry' => :'coatingDry',
        :'varnish' => :'varnish',
        :'varnish_sides' => :'varnishSides',
        :'varnish_dry' => :'varnishDry',
        :'binding_method' => :'bindingMethod',
        :'shipping_workflow' => :'shippingWorkflow',
        :'press_event_workflow' => :'pressEventWorkflow',
        :'prepress_workflow' => :'prepressWorkflow',
        :'speed_factor' => :'speedFactor',
        :'production_type' => :'productionType',
        :'final_size_h' => :'finalSizeH',
        :'final_size_w' => :'finalSizeW',
        :'price_list' => :'priceList',
        :'item_discount_percent' => :'itemDiscountPercent',
        :'product_type' => :'productType',
        :'virtual_printer' => :'virtualPrinter',
        :'include_mailing' => :'includeMailing',
        :'price_level' => :'priceLevel',
        :'sales_category' => :'salesCategory',
        :'quantity1' => :'quantity1',
        :'quantity1_desc' => :'quantity1Desc',
        :'quantity2' => :'quantity2',
        :'quantity2_desc' => :'quantity2Desc',
        :'quantity3' => :'quantity3',
        :'quantity3_desc' => :'quantity3Desc',
        :'quantity4' => :'quantity4',
        :'quantity4_desc' => :'quantity4Desc',
        :'quantity5' => :'quantity5',
        :'quantity5_desc' => :'quantity5Desc',
        :'quantity6' => :'quantity6',
        :'quantity6_desc' => :'quantity6Desc',
        :'quantity7' => :'quantity7',
        :'quantity7_desc' => :'quantity7Desc',
        :'quantity8' => :'quantity8',
        :'quantity8_desc' => :'quantity8Desc',
        :'quantity9' => :'quantity9',
        :'quantity9_desc' => :'quantity9Desc',
        :'quantity10' => :'quantity10',
        :'quantity10_desc' => :'quantity10Desc',
        :'commission_rate' => :'commissionRate',
        :'gripper_color_bar' => :'gripperColorBar',
        :'combo_percent' => :'comboPercent',
        :'estimate_press_info' => :'estimatePressInfo',
        :'estimate_paper_info' => :'estimatePaperInfo'
      }
    end
  end
end
