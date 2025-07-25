module Pace
  class EstimateIntentInfo < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :description

    attr_accessor :colors_side1

    attr_accessor :include_mailing

    attr_accessor :activity

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ink_coverage_back

    attr_accessor :sales_category

    attr_accessor :certification_authority

    attr_accessor :certification_level

    attr_accessor :taxable_code

    attr_accessor :sales_person

    attr_accessor :sales_tax

    attr_accessor :customer

    attr_accessor :inventory_item

    attr_accessor :alt_currency

    attr_accessor :price_level

    attr_accessor :uom

    attr_accessor :production_type

    attr_accessor :product

    attr_accessor :composite_product

    attr_accessor :colors_total

    attr_accessor :speed_factor

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :due_date

    attr_accessor :composite_pages

    attr_accessor :commission_rate

    attr_accessor :run_size_height

    attr_accessor :fold_pattern_key

    attr_accessor :virtual_printer

    attr_accessor :run_size_width

    attr_accessor :run_method

    attr_accessor :run_size_width_display_uom

    attr_accessor :fold_pattern

    attr_accessor :press_event_workflow

    attr_accessor :coating

    attr_accessor :varnish

    attr_accessor :run_size_height_display_uom

    attr_accessor :shipping_workflow

    attr_accessor :bleeds_across

    attr_accessor :bleeds_along

    attr_accessor :gripper_color_bar

    attr_accessor :grain_specifications

    attr_accessor :seam_direction

    attr_accessor :prepress_workflow

    attr_accessor :estimator

    attr_accessor :tile_product

    attr_accessor :gangable

    attr_accessor :num_plies

    attr_accessor :buy_size_width

    attr_accessor :buy_size_height_display_uom

    attr_accessor :buy_size_width_display_uom

    attr_accessor :difficulty

    attr_accessor :buy_size_height

    attr_accessor :paper_weight

    attr_accessor :coating_sides

    attr_accessor :stock_number

    attr_accessor :num_pages

    attr_accessor :run_method_forced

    attr_accessor :ink_coverage_front_specify

    attr_accessor :ink_coverage_front

    attr_accessor :varnish_dry

    attr_accessor :press_ink_type

    attr_accessor :coating_dry

    attr_accessor :varnish_sides

    attr_accessor :ink_coverage_back_specify

    attr_accessor :freight_on_board

    attr_accessor :quantity10

    attr_accessor :quantity1

    attr_accessor :quantity2

    attr_accessor :quantity7

    attr_accessor :quantity8

    attr_accessor :quantity9

    attr_accessor :quantity3

    attr_accessor :quantity4

    attr_accessor :quantity5

    attr_accessor :quantity6

    attr_accessor :price_level_forced

    attr_accessor :binding_method

    attr_accessor :opportunity

    attr_accessor :prospect_phone_ext

    attr_accessor :prospect_email

    attr_accessor :follow_up_date

    attr_accessor :delivery_date

    attr_accessor :prospect_country

    attr_accessor :prospect_address2

    attr_accessor :prospect_address3

    attr_accessor :prospect_address1

    attr_accessor :prospect_state

    attr_accessor :prospect_company

    attr_accessor :prospect_fax

    attr_accessor :prospect_zip

    attr_accessor :prospect_phone

    attr_accessor :prospect_name

    attr_accessor :prospect_fax_ext

    attr_accessor :estimate_number

    attr_accessor :prospect_city

    attr_accessor :prospect_state_key

    attr_accessor :budget_amount

    attr_accessor :vendor_paper

    attr_accessor :primary_press_forced

    attr_accessor :quantity9_desc

    attr_accessor :paper_quoted_price

    attr_accessor :quantity7_desc

    attr_accessor :vendor_paper_vendor

    attr_accessor :quantity4_desc

    attr_accessor :combo_percent

    attr_accessor :paper_source_forced

    attr_accessor :quantity10_desc

    attr_accessor :quantity2_desc

    attr_accessor :paper_quote_num

    attr_accessor :quantity1_desc

    attr_accessor :primary_press

    attr_accessor :quantity8_desc

    attr_accessor :paper_description

    attr_accessor :quantity6_desc

    attr_accessor :quantity5_desc

    attr_accessor :paper_source

    attr_accessor :alt_currency_paper

    attr_accessor :combo_percent_forced

    attr_accessor :material_type

    attr_accessor :quantity3_desc

    attr_accessor :each_of

    attr_accessor :alt_currency_paper_forced

    attr_accessor :part_description

    attr_accessor :uom_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'description' => :'description',
        :'colors_side1' => :'colorsSide1',
        :'include_mailing' => :'includeMailing',
        :'activity' => :'activity',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ink_coverage_back' => :'inkCoverageBack',
        :'sales_category' => :'salesCategory',
        :'certification_authority' => :'certificationAuthority',
        :'certification_level' => :'certificationLevel',
        :'taxable_code' => :'taxableCode',
        :'sales_person' => :'salesPerson',
        :'sales_tax' => :'salesTax',
        :'customer' => :'customer',
        :'inventory_item' => :'inventoryItem',
        :'alt_currency' => :'altCurrency',
        :'price_level' => :'priceLevel',
        :'uom' => :'uom',
        :'production_type' => :'productionType',
        :'product' => :'product',
        :'composite_product' => :'compositeProduct',
        :'colors_total' => :'colorsTotal',
        :'speed_factor' => :'speedFactor',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'due_date' => :'dueDate',
        :'composite_pages' => :'compositePages',
        :'commission_rate' => :'commissionRate',
        :'run_size_height' => :'runSizeHeight',
        :'fold_pattern_key' => :'foldPatternKey',
        :'virtual_printer' => :'virtualPrinter',
        :'run_size_width' => :'runSizeWidth',
        :'run_method' => :'runMethod',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'fold_pattern' => :'foldPattern',
        :'press_event_workflow' => :'pressEventWorkflow',
        :'coating' => :'coating',
        :'varnish' => :'varnish',
        :'run_size_height_display_uom' => :'runSizeHeightDisplayUOM',
        :'shipping_workflow' => :'shippingWorkflow',
        :'bleeds_across' => :'bleedsAcross',
        :'bleeds_along' => :'bleedsAlong',
        :'gripper_color_bar' => :'gripperColorBar',
        :'grain_specifications' => :'grainSpecifications',
        :'seam_direction' => :'seamDirection',
        :'prepress_workflow' => :'prepressWorkflow',
        :'estimator' => :'estimator',
        :'tile_product' => :'tileProduct',
        :'gangable' => :'gangable',
        :'num_plies' => :'numPlies',
        :'buy_size_width' => :'buySizeWidth',
        :'buy_size_height_display_uom' => :'buySizeHeightDisplayUOM',
        :'buy_size_width_display_uom' => :'buySizeWidthDisplayUOM',
        :'difficulty' => :'difficulty',
        :'buy_size_height' => :'buySizeHeight',
        :'paper_weight' => :'paperWeight',
        :'coating_sides' => :'coatingSides',
        :'stock_number' => :'stockNumber',
        :'num_pages' => :'numPages',
        :'run_method_forced' => :'runMethodForced',
        :'ink_coverage_front_specify' => :'inkCoverageFrontSpecify',
        :'ink_coverage_front' => :'inkCoverageFront',
        :'varnish_dry' => :'varnishDry',
        :'press_ink_type' => :'pressInkType',
        :'coating_dry' => :'coatingDry',
        :'varnish_sides' => :'varnishSides',
        :'ink_coverage_back_specify' => :'inkCoverageBackSpecify',
        :'freight_on_board' => :'freightOnBoard',
        :'quantity10' => :'quantity10',
        :'quantity1' => :'quantity1',
        :'quantity2' => :'quantity2',
        :'quantity7' => :'quantity7',
        :'quantity8' => :'quantity8',
        :'quantity9' => :'quantity9',
        :'quantity3' => :'quantity3',
        :'quantity4' => :'quantity4',
        :'quantity5' => :'quantity5',
        :'quantity6' => :'quantity6',
        :'price_level_forced' => :'priceLevelForced',
        :'binding_method' => :'bindingMethod',
        :'opportunity' => :'opportunity',
        :'prospect_phone_ext' => :'prospectPhoneExt',
        :'prospect_email' => :'prospectEmail',
        :'follow_up_date' => :'followUpDate',
        :'delivery_date' => :'deliveryDate',
        :'prospect_country' => :'prospectCountry',
        :'prospect_address2' => :'prospectAddress2',
        :'prospect_address3' => :'prospectAddress3',
        :'prospect_address1' => :'prospectAddress1',
        :'prospect_state' => :'prospectState',
        :'prospect_company' => :'prospectCompany',
        :'prospect_fax' => :'prospectFax',
        :'prospect_zip' => :'prospectZip',
        :'prospect_phone' => :'prospectPhone',
        :'prospect_name' => :'prospectName',
        :'prospect_fax_ext' => :'prospectFaxExt',
        :'estimate_number' => :'estimateNumber',
        :'prospect_city' => :'prospectCity',
        :'prospect_state_key' => :'prospectStateKey',
        :'budget_amount' => :'budgetAmount',
        :'vendor_paper' => :'vendorPaper',
        :'primary_press_forced' => :'primaryPressForced',
        :'quantity9_desc' => :'quantity9Desc',
        :'paper_quoted_price' => :'paperQuotedPrice',
        :'quantity7_desc' => :'quantity7Desc',
        :'vendor_paper_vendor' => :'vendorPaperVendor',
        :'quantity4_desc' => :'quantity4Desc',
        :'combo_percent' => :'comboPercent',
        :'paper_source_forced' => :'paperSourceForced',
        :'quantity10_desc' => :'quantity10Desc',
        :'quantity2_desc' => :'quantity2Desc',
        :'paper_quote_num' => :'paperQuoteNum',
        :'quantity1_desc' => :'quantity1Desc',
        :'primary_press' => :'primaryPress',
        :'quantity8_desc' => :'quantity8Desc',
        :'paper_description' => :'paperDescription',
        :'quantity6_desc' => :'quantity6Desc',
        :'quantity5_desc' => :'quantity5Desc',
        :'paper_source' => :'paperSource',
        :'alt_currency_paper' => :'altCurrencyPaper',
        :'combo_percent_forced' => :'comboPercentForced',
        :'material_type' => :'materialType',
        :'quantity3_desc' => :'quantity3Desc',
        :'each_of' => :'eachOf',
        :'alt_currency_paper_forced' => :'altCurrencyPaperForced',
        :'part_description' => :'partDescription',
        :'uom_forced' => :'uomForced'
      }
    end
  end
end
