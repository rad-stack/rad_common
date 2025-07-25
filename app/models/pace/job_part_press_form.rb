module Pace
  class JobPartPressForm < Base
    attr_accessor :id

    attr_accessor :locked

    attr_accessor :time

    attr_accessor :colors

    attr_accessor :description

    attr_accessor :page_repeat

    attr_accessor :layout

    attr_accessor :colors_side1

    attr_accessor :_end

    attr_accessor :qty_to_mfg

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :plant_manager_id

    attr_accessor :item_template

    attr_accessor :note

    attr_accessor :inventory_item

    attr_accessor :job_material

    attr_accessor :press

    attr_accessor :make_ready_hours

    attr_accessor :num_across

    attr_accessor :num_up

    attr_accessor :num_along

    attr_accessor :num_passes

    attr_accessor :num_sigs

    attr_accessor :colors_total

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :quote_source

    attr_accessor :run_spoilage_sheets

    attr_accessor :page_range

    attr_accessor :other_hours

    attr_accessor :run_size_height

    attr_accessor :second_web

    attr_accessor :insert_type

    attr_accessor :tab_text

    attr_accessor :non_printed

    attr_accessor :filter_press_events_by_press

    attr_accessor :fold_pattern_key

    attr_accessor :grain_direction

    attr_accessor :run_hours

    attr_accessor :panel_size_height_display_uom

    attr_accessor :number_panels

    attr_accessor :panel_size_height

    attr_accessor :virtual_printer

    attr_accessor :scheduled_press

    attr_accessor :in_home_date

    attr_accessor :run_size_width

    attr_accessor :due_date_time

    attr_accessor :duplex_mode

    attr_accessor :run_method

    attr_accessor :registration

    attr_accessor :press_indicator

    attr_accessor :color_split

    attr_accessor :qty_shipped

    attr_accessor :plate

    attr_accessor :output_resource_id

    attr_accessor :run_size

    attr_accessor :secondary_display_sort_order

    attr_accessor :quantity_remaining

    attr_accessor :printable_order_detail_id

    attr_accessor :two_up_split

    attr_accessor :image_shift_y_axis

    attr_accessor :make_ready_sheets

    attr_accessor :washup_hours

    attr_accessor :metrix_component_id

    attr_accessor :ganged_run

    attr_accessor :panel_size_width

    attr_accessor :export_profile

    attr_accessor :split_description

    attr_accessor :impressions_per_hour

    attr_accessor :pace_connect_file_name

    attr_accessor :off_press_qty

    attr_accessor :runs

    attr_accessor :roll_change_length_uom

    attr_accessor :run_date

    attr_accessor :ink_coating_sides

    attr_accessor :process_status

    attr_accessor :beg

    attr_accessor :document_output

    attr_accessor :sheets_per_copy

    attr_accessor :run

    attr_accessor :run_size_width_display_uom

    attr_accessor :scheduled_flag

    attr_accessor :binder_insert_repeat

    attr_accessor :body

    attr_accessor :jdf_submitted

    attr_accessor :fold_pattern

    attr_accessor :ink_varnish_dry

    attr_accessor :pages

    attr_accessor :job_contact

    attr_accessor :roll_change_length_forced

    attr_accessor :roll_change_length

    attr_accessor :pace_connect_file_type

    attr_accessor :print_run_method

    attr_accessor :display_graphics

    attr_accessor :pace_connect_url

    attr_accessor :printing_job_plan

    attr_accessor :material_up

    attr_accessor :attribute_split

    attr_accessor :pattern_category

    attr_accessor :num_plates

    attr_accessor :display_sort_order

    attr_accessor :run_impressions

    attr_accessor :plant_manager_material_consumed

    attr_accessor :form_num

    attr_accessor :sheet_count

    attr_accessor :metrix_id

    attr_accessor :ink_coating

    attr_accessor :scheduled

    attr_accessor :ink_varnish_sides

    attr_accessor :lift_change

    attr_accessor :page_range_display

    attr_accessor :finishing_make_ready_sheets

    attr_accessor :ink_varnish

    attr_accessor :num_blanks

    attr_accessor :ink_coating_dry

    attr_accessor :press_event_workflow

    attr_accessor :queue_entry_id

    attr_accessor :use_legacy_print_flow_format

    attr_accessor :orientation

    attr_accessor :page_count

    attr_accessor :panel_size_width_display_uom

    attr_accessor :coating

    attr_accessor :layout_number

    attr_accessor :varnish

    attr_accessor :export_locked_layouts

    attr_accessor :finishing_run_spoilage_sheets

    attr_accessor :run_size_height_display_uom

    attr_accessor :image_shift_x_axis

    attr_accessor :press_sheets

    attr_accessor :pace_connect_file_size

    attr_accessor :planned_quantityof_this_press_form


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'locked' => :'locked',
        :'time' => :'time',
        :'colors' => :'colors',
        :'description' => :'description',
        :'page_repeat' => :'pageRepeat',
        :'layout' => :'layout',
        :'colors_side1' => :'colorsSide1',
        :'_end' => :'end',
        :'qty_to_mfg' => :'qtyToMfg',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'plant_manager_id' => :'plantManagerId',
        :'item_template' => :'itemTemplate',
        :'note' => :'note',
        :'inventory_item' => :'inventoryItem',
        :'job_material' => :'jobMaterial',
        :'press' => :'press',
        :'make_ready_hours' => :'makeReadyHours',
        :'num_across' => :'numAcross',
        :'num_up' => :'numUp',
        :'num_along' => :'numAlong',
        :'num_passes' => :'numPasses',
        :'num_sigs' => :'numSigs',
        :'colors_total' => :'colorsTotal',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'quote_source' => :'quoteSource',
        :'run_spoilage_sheets' => :'runSpoilageSheets',
        :'page_range' => :'pageRange',
        :'other_hours' => :'otherHours',
        :'run_size_height' => :'runSizeHeight',
        :'second_web' => :'secondWeb',
        :'insert_type' => :'insertType',
        :'tab_text' => :'tabText',
        :'non_printed' => :'nonPrinted',
        :'filter_press_events_by_press' => :'filterPressEventsByPress',
        :'fold_pattern_key' => :'foldPatternKey',
        :'grain_direction' => :'grainDirection',
        :'run_hours' => :'runHours',
        :'panel_size_height_display_uom' => :'panelSizeHeightDisplayUOM',
        :'number_panels' => :'numberPanels',
        :'panel_size_height' => :'panelSizeHeight',
        :'virtual_printer' => :'virtualPrinter',
        :'scheduled_press' => :'scheduledPress',
        :'in_home_date' => :'inHomeDate',
        :'run_size_width' => :'runSizeWidth',
        :'due_date_time' => :'dueDateTime',
        :'duplex_mode' => :'duplexMode',
        :'run_method' => :'runMethod',
        :'registration' => :'registration',
        :'press_indicator' => :'pressIndicator',
        :'color_split' => :'colorSplit',
        :'qty_shipped' => :'qtyShipped',
        :'plate' => :'plate',
        :'output_resource_id' => :'outputResourceID',
        :'run_size' => :'runSize',
        :'secondary_display_sort_order' => :'secondaryDisplaySortOrder',
        :'quantity_remaining' => :'quantityRemaining',
        :'printable_order_detail_id' => :'printableOrderDetailID',
        :'two_up_split' => :'twoUpSplit',
        :'image_shift_y_axis' => :'imageShiftYAxis',
        :'make_ready_sheets' => :'makeReadySheets',
        :'washup_hours' => :'washupHours',
        :'metrix_component_id' => :'metrixComponentID',
        :'ganged_run' => :'gangedRun',
        :'panel_size_width' => :'panelSizeWidth',
        :'export_profile' => :'exportProfile',
        :'split_description' => :'splitDescription',
        :'impressions_per_hour' => :'impressionsPerHour',
        :'pace_connect_file_name' => :'paceConnectFileName',
        :'off_press_qty' => :'offPressQty',
        :'runs' => :'runs',
        :'roll_change_length_uom' => :'rollChangeLengthUom',
        :'run_date' => :'runDate',
        :'ink_coating_sides' => :'inkCoatingSides',
        :'process_status' => :'processStatus',
        :'beg' => :'beg',
        :'document_output' => :'documentOutput',
        :'sheets_per_copy' => :'sheetsPerCopy',
        :'run' => :'run',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'scheduled_flag' => :'scheduledFlag',
        :'binder_insert_repeat' => :'binderInsertRepeat',
        :'body' => :'body',
        :'jdf_submitted' => :'jdfSubmitted',
        :'fold_pattern' => :'foldPattern',
        :'ink_varnish_dry' => :'inkVarnishDry',
        :'pages' => :'pages',
        :'job_contact' => :'jobContact',
        :'roll_change_length_forced' => :'rollChangeLengthForced',
        :'roll_change_length' => :'rollChangeLength',
        :'pace_connect_file_type' => :'paceConnectFileType',
        :'print_run_method' => :'printRunMethod',
        :'display_graphics' => :'displayGraphics',
        :'pace_connect_url' => :'paceConnectURL',
        :'printing_job_plan' => :'printingJobPlan',
        :'material_up' => :'materialUp',
        :'attribute_split' => :'attributeSplit',
        :'pattern_category' => :'patternCategory',
        :'num_plates' => :'numPlates',
        :'display_sort_order' => :'displaySortOrder',
        :'run_impressions' => :'runImpressions',
        :'plant_manager_material_consumed' => :'plantManagerMaterialConsumed',
        :'form_num' => :'formNum',
        :'sheet_count' => :'sheetCount',
        :'metrix_id' => :'metrixID',
        :'ink_coating' => :'inkCoating',
        :'scheduled' => :'scheduled',
        :'ink_varnish_sides' => :'inkVarnishSides',
        :'lift_change' => :'liftChange',
        :'page_range_display' => :'pageRangeDisplay',
        :'finishing_make_ready_sheets' => :'finishingMakeReadySheets',
        :'ink_varnish' => :'inkVarnish',
        :'num_blanks' => :'numBlanks',
        :'ink_coating_dry' => :'inkCoatingDry',
        :'press_event_workflow' => :'pressEventWorkflow',
        :'queue_entry_id' => :'queueEntryID',
        :'use_legacy_print_flow_format' => :'useLegacyPrintFlowFormat',
        :'orientation' => :'orientation',
        :'page_count' => :'pageCount',
        :'panel_size_width_display_uom' => :'panelSizeWidthDisplayUOM',
        :'coating' => :'coating',
        :'layout_number' => :'layoutNumber',
        :'varnish' => :'varnish',
        :'export_locked_layouts' => :'exportLockedLayouts',
        :'finishing_run_spoilage_sheets' => :'finishingRunSpoilageSheets',
        :'run_size_height_display_uom' => :'runSizeHeightDisplayUOM',
        :'image_shift_x_axis' => :'imageShiftXAxis',
        :'press_sheets' => :'pressSheets',
        :'pace_connect_file_size' => :'paceConnectFileSize',
        :'planned_quantityof_this_press_form' => :'plannedQuantityofThisPressForm'
      }
    end
  end
end
