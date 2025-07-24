module Pace
  class EstimatePress < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :locked

    attr_accessor :number_helpers

    attr_accessor :page_repeat

    attr_accessor :layout

    attr_accessor :colors_side1

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ink_coverage_back

    attr_accessor :finishing_run_spoilage_sheets_forced

    attr_accessor :correlation_id

    attr_accessor :estimate_quantity

    attr_accessor :press

    attr_accessor :num_stagger_forced

    attr_accessor :make_ready_hours

    attr_accessor :num_across

    attr_accessor :num_across_forced

    attr_accessor :num_along_forced

    attr_accessor :num_passes_forced

    attr_accessor :num_up

    attr_accessor :number_helpers_forced

    attr_accessor :num_stagger

    attr_accessor :num_along

    attr_accessor :num_up_forced

    attr_accessor :num_passes

    attr_accessor :run_spoilage_percent

    attr_accessor :make_ready_hours_forced

    attr_accessor :colors_total

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :run_spoilage_sheets

    attr_accessor :page_range

    attr_accessor :other_hours

    attr_accessor :run_size_height

    attr_accessor :insert_type

    attr_accessor :non_printed

    attr_accessor :grain_direction

    attr_accessor :run_hours

    attr_accessor :panel_size_height_display_uom

    attr_accessor :number_panels

    attr_accessor :panel_size_height

    attr_accessor :virtual_printer

    attr_accessor :run_size_width

    attr_accessor :duplex_mode

    attr_accessor :run_method

    attr_accessor :registration

    attr_accessor :press_indicator

    attr_accessor :color_split

    attr_accessor :plate

    attr_accessor :two_up_split

    attr_accessor :image_shift_y_axis

    attr_accessor :make_ready_sheets

    attr_accessor :washup_hours

    attr_accessor :metrix_component_id

    attr_accessor :panel_size_width

    attr_accessor :export_profile

    attr_accessor :impressions_per_hour

    attr_accessor :roll_change_length_uom

    attr_accessor :document_output

    attr_accessor :sheets_per_copy

    attr_accessor :run

    attr_accessor :run_size_width_display_uom

    attr_accessor :binder_insert_repeat

    attr_accessor :body

    attr_accessor :roll_change_length_forced

    attr_accessor :roll_change_length

    attr_accessor :print_run_method

    attr_accessor :display_graphics

    attr_accessor :material_up

    attr_accessor :attribute_split

    attr_accessor :num_plates

    attr_accessor :display_sort_order

    attr_accessor :run_impressions

    attr_accessor :sheet_count

    attr_accessor :metrix_id

    attr_accessor :lift_change

    attr_accessor :page_range_display

    attr_accessor :finishing_make_ready_sheets

    attr_accessor :num_blanks

    attr_accessor :orientation

    attr_accessor :page_count

    attr_accessor :panel_size_width_display_uom

    attr_accessor :coating

    attr_accessor :layout_number

    attr_accessor :varnish

    attr_accessor :finishing_run_spoilage_sheets

    attr_accessor :run_size_height_display_uom

    attr_accessor :image_shift_x_axis

    attr_accessor :press_sheets

    attr_accessor :planned_quantityof_this_press_form

    attr_accessor :total_hours

    attr_accessor :num_press_forms

    attr_accessor :side_allowance

    attr_accessor :side_allowance_display_uom

    attr_accessor :coating_sides

    attr_accessor :material_gap

    attr_accessor :varnish_needs_plate

    attr_accessor :material_gap_display_uom

    attr_accessor :ink_changed

    attr_accessor :duplex_mode_forced

    attr_accessor :plate_forced

    attr_accessor :forced_run_size

    attr_accessor :num_washups

    attr_accessor :num_plate_changes

    attr_accessor :run_method_forced

    attr_accessor :num_washups_forced

    attr_accessor :clicks_impressions

    attr_accessor :print_run_method_forced

    attr_accessor :lift_change_forced

    attr_accessor :paper_speed_adjustment_forced

    attr_accessor :grain_direction_forced

    attr_accessor :run_impressions_forced

    attr_accessor :num_press_sheets_from_buy_forced

    attr_accessor :varnish_changed

    attr_accessor :press_form_change

    attr_accessor :ink_coverage_front_specify

    attr_accessor :make_ready_sheets_forced

    attr_accessor :ink_coverage_front

    attr_accessor :washup_hours_forced

    attr_accessor :ink_default

    attr_accessor :run_spoilage_percent_forced

    attr_accessor :num_press_sheets_from_buy

    attr_accessor :make_ready_time_per_sheet

    attr_accessor :varnish_dry

    attr_accessor :finishing_make_ready_sheets_forced

    attr_accessor :num_sigs_per_press_form

    attr_accessor :press_ink_type

    attr_accessor :side_allowance_forced

    attr_accessor :estimate_paper

    attr_accessor :num_plates_forced

    attr_accessor :coating_changed

    attr_accessor :mxml

    attr_accessor :next_press_spoilage

    attr_accessor :number_panels_forced

    attr_accessor :plates_required

    attr_accessor :previous_press

    attr_accessor :num_plate_changes_forced

    attr_accessor :press_sheets_forced

    attr_accessor :run_hours_forced

    attr_accessor :other_hours_forced

    attr_accessor :max_possible_num_up

    attr_accessor :press_forced

    attr_accessor :registration_forced

    attr_accessor :coating_dry

    attr_accessor :varnish_sides

    attr_accessor :forced_panel_size

    attr_accessor :run_spoilage_sheets_forced

    attr_accessor :paper_speed_adjustment

    attr_accessor :impressions_per_hour_forced

    attr_accessor :ink_coverage_back_specify

    attr_accessor :overall_ink_coverage_side2

    attr_accessor :overall_ink_coverage_side1


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'locked' => :'locked',
        :'number_helpers' => :'numberHelpers',
        :'page_repeat' => :'pageRepeat',
        :'layout' => :'layout',
        :'colors_side1' => :'colorsSide1',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ink_coverage_back' => :'inkCoverageBack',
        :'finishing_run_spoilage_sheets_forced' => :'finishingRunSpoilageSheetsForced',
        :'correlation_id' => :'correlationId',
        :'estimate_quantity' => :'estimateQuantity',
        :'press' => :'press',
        :'num_stagger_forced' => :'numStaggerForced',
        :'make_ready_hours' => :'makeReadyHours',
        :'num_across' => :'numAcross',
        :'num_across_forced' => :'numAcrossForced',
        :'num_along_forced' => :'numAlongForced',
        :'num_passes_forced' => :'numPassesForced',
        :'num_up' => :'numUp',
        :'number_helpers_forced' => :'numberHelpersForced',
        :'num_stagger' => :'numStagger',
        :'num_along' => :'numAlong',
        :'num_up_forced' => :'numUpForced',
        :'num_passes' => :'numPasses',
        :'run_spoilage_percent' => :'runSpoilagePercent',
        :'make_ready_hours_forced' => :'makeReadyHoursForced',
        :'colors_total' => :'colorsTotal',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'run_spoilage_sheets' => :'runSpoilageSheets',
        :'page_range' => :'pageRange',
        :'other_hours' => :'otherHours',
        :'run_size_height' => :'runSizeHeight',
        :'insert_type' => :'insertType',
        :'non_printed' => :'nonPrinted',
        :'grain_direction' => :'grainDirection',
        :'run_hours' => :'runHours',
        :'panel_size_height_display_uom' => :'panelSizeHeightDisplayUOM',
        :'number_panels' => :'numberPanels',
        :'panel_size_height' => :'panelSizeHeight',
        :'virtual_printer' => :'virtualPrinter',
        :'run_size_width' => :'runSizeWidth',
        :'duplex_mode' => :'duplexMode',
        :'run_method' => :'runMethod',
        :'registration' => :'registration',
        :'press_indicator' => :'pressIndicator',
        :'color_split' => :'colorSplit',
        :'plate' => :'plate',
        :'two_up_split' => :'twoUpSplit',
        :'image_shift_y_axis' => :'imageShiftYAxis',
        :'make_ready_sheets' => :'makeReadySheets',
        :'washup_hours' => :'washupHours',
        :'metrix_component_id' => :'metrixComponentID',
        :'panel_size_width' => :'panelSizeWidth',
        :'export_profile' => :'exportProfile',
        :'impressions_per_hour' => :'impressionsPerHour',
        :'roll_change_length_uom' => :'rollChangeLengthUom',
        :'document_output' => :'documentOutput',
        :'sheets_per_copy' => :'sheetsPerCopy',
        :'run' => :'run',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'binder_insert_repeat' => :'binderInsertRepeat',
        :'body' => :'body',
        :'roll_change_length_forced' => :'rollChangeLengthForced',
        :'roll_change_length' => :'rollChangeLength',
        :'print_run_method' => :'printRunMethod',
        :'display_graphics' => :'displayGraphics',
        :'material_up' => :'materialUp',
        :'attribute_split' => :'attributeSplit',
        :'num_plates' => :'numPlates',
        :'display_sort_order' => :'displaySortOrder',
        :'run_impressions' => :'runImpressions',
        :'sheet_count' => :'sheetCount',
        :'metrix_id' => :'metrixID',
        :'lift_change' => :'liftChange',
        :'page_range_display' => :'pageRangeDisplay',
        :'finishing_make_ready_sheets' => :'finishingMakeReadySheets',
        :'num_blanks' => :'numBlanks',
        :'orientation' => :'orientation',
        :'page_count' => :'pageCount',
        :'panel_size_width_display_uom' => :'panelSizeWidthDisplayUOM',
        :'coating' => :'coating',
        :'layout_number' => :'layoutNumber',
        :'varnish' => :'varnish',
        :'finishing_run_spoilage_sheets' => :'finishingRunSpoilageSheets',
        :'run_size_height_display_uom' => :'runSizeHeightDisplayUOM',
        :'image_shift_x_axis' => :'imageShiftXAxis',
        :'press_sheets' => :'pressSheets',
        :'planned_quantityof_this_press_form' => :'plannedQuantityofThisPressForm',
        :'total_hours' => :'totalHours',
        :'num_press_forms' => :'numPressForms',
        :'side_allowance' => :'sideAllowance',
        :'side_allowance_display_uom' => :'sideAllowanceDisplayUOM',
        :'coating_sides' => :'coatingSides',
        :'material_gap' => :'materialGap',
        :'varnish_needs_plate' => :'varnishNeedsPlate',
        :'material_gap_display_uom' => :'materialGapDisplayUOM',
        :'ink_changed' => :'inkChanged',
        :'duplex_mode_forced' => :'duplexModeForced',
        :'plate_forced' => :'plateForced',
        :'forced_run_size' => :'forcedRunSize',
        :'num_washups' => :'numWashups',
        :'num_plate_changes' => :'numPlateChanges',
        :'run_method_forced' => :'runMethodForced',
        :'num_washups_forced' => :'numWashupsForced',
        :'clicks_impressions' => :'clicksImpressions',
        :'print_run_method_forced' => :'printRunMethodForced',
        :'lift_change_forced' => :'liftChangeForced',
        :'paper_speed_adjustment_forced' => :'paperSpeedAdjustmentForced',
        :'grain_direction_forced' => :'grainDirectionForced',
        :'run_impressions_forced' => :'runImpressionsForced',
        :'num_press_sheets_from_buy_forced' => :'numPressSheetsFromBuyForced',
        :'varnish_changed' => :'varnishChanged',
        :'press_form_change' => :'pressFormChange',
        :'ink_coverage_front_specify' => :'inkCoverageFrontSpecify',
        :'make_ready_sheets_forced' => :'makeReadySheetsForced',
        :'ink_coverage_front' => :'inkCoverageFront',
        :'washup_hours_forced' => :'washupHoursForced',
        :'ink_default' => :'inkDefault',
        :'run_spoilage_percent_forced' => :'runSpoilagePercentForced',
        :'num_press_sheets_from_buy' => :'numPressSheetsFromBuy',
        :'make_ready_time_per_sheet' => :'makeReadyTimePerSheet',
        :'varnish_dry' => :'varnishDry',
        :'finishing_make_ready_sheets_forced' => :'finishingMakeReadySheetsForced',
        :'num_sigs_per_press_form' => :'numSigsPerPressForm',
        :'press_ink_type' => :'pressInkType',
        :'side_allowance_forced' => :'sideAllowanceForced',
        :'estimate_paper' => :'estimatePaper',
        :'num_plates_forced' => :'numPlatesForced',
        :'coating_changed' => :'coatingChanged',
        :'mxml' => :'mxml',
        :'next_press_spoilage' => :'nextPressSpoilage',
        :'number_panels_forced' => :'numberPanelsForced',
        :'plates_required' => :'platesRequired',
        :'previous_press' => :'previousPress',
        :'num_plate_changes_forced' => :'numPlateChangesForced',
        :'press_sheets_forced' => :'pressSheetsForced',
        :'run_hours_forced' => :'runHoursForced',
        :'other_hours_forced' => :'otherHoursForced',
        :'max_possible_num_up' => :'maxPossibleNumUp',
        :'press_forced' => :'pressForced',
        :'registration_forced' => :'registrationForced',
        :'coating_dry' => :'coatingDry',
        :'varnish_sides' => :'varnishSides',
        :'forced_panel_size' => :'forcedPanelSize',
        :'run_spoilage_sheets_forced' => :'runSpoilageSheetsForced',
        :'paper_speed_adjustment' => :'paperSpeedAdjustment',
        :'impressions_per_hour_forced' => :'impressionsPerHourForced',
        :'ink_coverage_back_specify' => :'inkCoverageBackSpecify',
        :'overall_ink_coverage_side2' => :'overallInkCoverageSide2',
        :'overall_ink_coverage_side1' => :'overallInkCoverageSide1'
      }
    end
  end
end
