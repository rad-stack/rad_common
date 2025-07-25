module Pace
  class JobProductType < Base
    attr_accessor :component_type

    attr_accessor :id

    attr_accessor :active

    attr_accessor :certification_product_classification

    attr_accessor :description

    attr_accessor :colors_side1

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :use_price_list_pricing

    attr_accessor :network_location

    attr_accessor :tax_category

    attr_accessor :customer

    attr_accessor :inventory_item

    attr_accessor :outside_purchase_workflow

    attr_accessor :press

    attr_accessor :num_across

    attr_accessor :num_up

    attr_accessor :num_stagger

    attr_accessor :num_along

    attr_accessor :production_type

    attr_accessor :additional_description

    attr_accessor :user_interface_set

    attr_accessor :colors_total

    attr_accessor :routing_template

    attr_accessor :speed_factor

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :metrix_enabled

    attr_accessor :manufacturing_locations

    attr_accessor :run_size_height

    attr_accessor :second_web

    attr_accessor :fold_pattern_key

    attr_accessor :grain_direction

    attr_accessor :run_size_width

    attr_accessor :duplex_mode

    attr_accessor :run_method

    attr_accessor :run_size_width_display_uom

    attr_accessor :print_run_method

    attr_accessor :pattern_category

    attr_accessor :press_event_workflow

    attr_accessor :coating

    attr_accessor :varnish

    attr_accessor :run_size_height_display_uom

    attr_accessor :shipping_workflow

    attr_accessor :bleeds_across

    attr_accessor :bleeds_along

    attr_accessor :gripper_color_bar

    attr_accessor :grain_specifications

    attr_accessor :prepress_workflow

    attr_accessor :separate_layout

    attr_accessor :gangable

    attr_accessor :num_plies

    attr_accessor :final_size_height

    attr_accessor :comm_rate

    attr_accessor :final_size_height_display_uom

    attr_accessor :metrix_accessible

    attr_accessor :default_item_product_condition

    attr_accessor :buy_size_width

    attr_accessor :buy_size_height_display_uom

    attr_accessor :page_assembly_order

    attr_accessor :file_name_pattern

    attr_accessor :items_bindery

    attr_accessor :buy_size_width_display_uom

    attr_accessor :auto_create_job_part_content_file

    attr_accessor :difficulty

    attr_accessor :standard_paper_type

    attr_accessor :buy_size_height

    attr_accessor :paper_weight

    attr_accessor :final_size_width

    attr_accessor :mailing

    attr_accessor :paper

    attr_accessor :run_size_grain_direction

    attr_accessor :each_of_pricing

    attr_accessor :item_product_type

    attr_accessor :suppress_zero_priced_items

    attr_accessor :combo_split

    attr_accessor :final_size_width_display_uom

    attr_accessor :auto_schedule

    attr_accessor :items_fold_pattern

    attr_accessor :available_ecommerce

    attr_accessor :coating_sides

    attr_accessor :num_pages

    attr_accessor :ink_default

    attr_accessor :varnish_dry

    attr_accessor :press_ink_type

    attr_accessor :coating_dry

    attr_accessor :varnish_sides


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'component_type' => :'componentType',
        :'id' => :'id',
        :'active' => :'active',
        :'certification_product_classification' => :'certificationProductClassification',
        :'description' => :'description',
        :'colors_side1' => :'colorsSide1',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'use_price_list_pricing' => :'usePriceListPricing',
        :'network_location' => :'networkLocation',
        :'tax_category' => :'taxCategory',
        :'customer' => :'customer',
        :'inventory_item' => :'inventoryItem',
        :'outside_purchase_workflow' => :'outsidePurchaseWorkflow',
        :'press' => :'press',
        :'num_across' => :'numAcross',
        :'num_up' => :'numUp',
        :'num_stagger' => :'numStagger',
        :'num_along' => :'numAlong',
        :'production_type' => :'productionType',
        :'additional_description' => :'additionalDescription',
        :'user_interface_set' => :'userInterfaceSet',
        :'colors_total' => :'colorsTotal',
        :'routing_template' => :'routingTemplate',
        :'speed_factor' => :'speedFactor',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'metrix_enabled' => :'metrixEnabled',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'run_size_height' => :'runSizeHeight',
        :'second_web' => :'secondWeb',
        :'fold_pattern_key' => :'foldPatternKey',
        :'grain_direction' => :'grainDirection',
        :'run_size_width' => :'runSizeWidth',
        :'duplex_mode' => :'duplexMode',
        :'run_method' => :'runMethod',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'print_run_method' => :'printRunMethod',
        :'pattern_category' => :'patternCategory',
        :'press_event_workflow' => :'pressEventWorkflow',
        :'coating' => :'coating',
        :'varnish' => :'varnish',
        :'run_size_height_display_uom' => :'runSizeHeightDisplayUOM',
        :'shipping_workflow' => :'shippingWorkflow',
        :'bleeds_across' => :'bleedsAcross',
        :'bleeds_along' => :'bleedsAlong',
        :'gripper_color_bar' => :'gripperColorBar',
        :'grain_specifications' => :'grainSpecifications',
        :'prepress_workflow' => :'prepressWorkflow',
        :'separate_layout' => :'separateLayout',
        :'gangable' => :'gangable',
        :'num_plies' => :'numPlies',
        :'final_size_height' => :'finalSizeHeight',
        :'comm_rate' => :'commRate',
        :'final_size_height_display_uom' => :'finalSizeHeightDisplayUOM',
        :'metrix_accessible' => :'metrixAccessible',
        :'default_item_product_condition' => :'defaultItemProductCondition',
        :'buy_size_width' => :'buySizeWidth',
        :'buy_size_height_display_uom' => :'buySizeHeightDisplayUOM',
        :'page_assembly_order' => :'pageAssemblyOrder',
        :'file_name_pattern' => :'fileNamePattern',
        :'items_bindery' => :'itemsBindery',
        :'buy_size_width_display_uom' => :'buySizeWidthDisplayUOM',
        :'auto_create_job_part_content_file' => :'autoCreateJobPartContentFile',
        :'difficulty' => :'difficulty',
        :'standard_paper_type' => :'standardPaperType',
        :'buy_size_height' => :'buySizeHeight',
        :'paper_weight' => :'paperWeight',
        :'final_size_width' => :'finalSizeWidth',
        :'mailing' => :'mailing',
        :'paper' => :'paper',
        :'run_size_grain_direction' => :'runSizeGrainDirection',
        :'each_of_pricing' => :'eachOfPricing',
        :'item_product_type' => :'itemProductType',
        :'suppress_zero_priced_items' => :'suppressZeroPricedItems',
        :'combo_split' => :'comboSplit',
        :'final_size_width_display_uom' => :'finalSizeWidthDisplayUOM',
        :'auto_schedule' => :'autoSchedule',
        :'items_fold_pattern' => :'itemsFoldPattern',
        :'available_ecommerce' => :'availableEcommerce',
        :'coating_sides' => :'coatingSides',
        :'num_pages' => :'numPages',
        :'ink_default' => :'inkDefault',
        :'varnish_dry' => :'varnishDry',
        :'press_ink_type' => :'pressInkType',
        :'coating_dry' => :'coatingDry',
        :'varnish_sides' => :'varnishSides'
      }
    end
  end
end
