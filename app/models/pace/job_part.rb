module Pace
  class JobPart < Base
    attr_accessor :value

    attr_accessor :priority

    attr_accessor :certification_product_classification

    attr_accessor :colors

    attr_accessor :description

    attr_accessor :visual_opening_size_width_display_uom

    attr_accessor :job_cost01

    attr_accessor :include_mailing

    attr_accessor :qty_to_mfg

    attr_accessor :num_prs_shts_out

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :primary_key

    attr_accessor :invoice_date

    attr_accessor :content_file

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sales_category

    attr_accessor :plant_manager_id

    attr_accessor :certification_authority

    attr_accessor :bill_rate

    attr_accessor :certification_level

    attr_accessor :contact_num

    attr_accessor :tax_category

    attr_accessor :ship_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :item_template

    attr_accessor :date_time_setup

    attr_accessor :estimate_part

    attr_accessor :quoted_price

    attr_accessor :quoted_price_forced

    attr_accessor :job_product

    attr_accessor :outside_purchase_workflow

    attr_accessor :folder

    attr_accessor :production_type

    attr_accessor :non_planned_reason

    attr_accessor :additional_description

    attr_accessor :product

    attr_accessor :estimate

    attr_accessor :user_interface_set

    attr_accessor :final_size_w

    attr_accessor :colors_s2

    attr_accessor :colors_s1

    attr_accessor :final_size_w_display_uom

    attr_accessor :final_size_h

    attr_accessor :num_sigs

    attr_accessor :final_size_h_display_uom

    attr_accessor :colors_total

    attr_accessor :qty_ordered

    attr_accessor :routing_template

    attr_accessor :speed_factor

    attr_accessor :estimated_cost

    attr_accessor :metrix_enabled

    attr_accessor :calculating

    attr_accessor :odd_panel_spine_size

    attr_accessor :odd_panel_width_size_display_uom

    attr_accessor :odd_panel_spine_size_display_uom

    attr_accessor :fold_pattern_key

    attr_accessor :virtual_printer

    attr_accessor :due_date_time

    attr_accessor :run_method

    attr_accessor :qty_shipped

    attr_accessor :output_resource_id

    attr_accessor :quantity_remaining

    attr_accessor :printable_order_detail_id

    attr_accessor :metrix_component_id

    attr_accessor :pace_connect_file_name

    attr_accessor :process_status

    attr_accessor :run

    attr_accessor :scheduled_flag

    attr_accessor :jdf_submitted

    attr_accessor :fold_pattern

    attr_accessor :pages

    attr_accessor :job_contact

    attr_accessor :pace_connect_file_type

    attr_accessor :print_run_method

    attr_accessor :pace_connect_url

    attr_accessor :pattern_category

    attr_accessor :form_num

    attr_accessor :metrix_id

    attr_accessor :scheduled

    attr_accessor :queue_entry_id

    attr_accessor :use_legacy_print_flow_format

    attr_accessor :pace_connect_file_size

    attr_accessor :odd_panel_width_size

    attr_accessor :num_odd_panels_spine

    attr_accessor :num_odd_panels_width

    attr_accessor :print_stream_item_id

    attr_accessor :sheets_to_press

    attr_accessor :stitcher_num_up

    attr_accessor :lock_sales_dists

    attr_accessor :calculated_odd_panel_width_size

    attr_accessor :finished_auto_import

    attr_accessor :shipping_workflow

    attr_accessor :spine_size_display_uom

    attr_accessor :resolution

    attr_accessor :w2p_shipping_amount

    attr_accessor :original_quoted_price_forced

    attr_accessor :collate_on_printer

    attr_accessor :other_press_work

    attr_accessor :prep

    attr_accessor :proof_required

    attr_accessor :spine_size

    attr_accessor :w2p_tax_amount

    attr_accessor :calculated_front_overfold

    attr_accessor :material_provided

    attr_accessor :act5_note

    attr_accessor :non_image_face

    attr_accessor :calculated_trim_head

    attr_accessor :mxml_layout_invalid

    attr_accessor :reading_direction

    attr_accessor :right_folds

    attr_accessor :bleeds_across

    attr_accessor :bleeds_along

    attr_accessor :freight_amt

    attr_accessor :proofs

    attr_accessor :gripper_color_bar

    attr_accessor :calculated_odd_panel_spine_size

    attr_accessor :invoice_sequence

    attr_accessor :non_image_foot

    attr_accessor :non_image_foot_display_uom

    attr_accessor :original_quoted_price_per_m

    attr_accessor :trim_face

    attr_accessor :total_digital_pages

    attr_accessor :bleeds_foot

    attr_accessor :bleed_size_display_uom

    attr_accessor :flat_size_w

    attr_accessor :fiscal_week_set

    attr_accessor :job_part_import_id

    attr_accessor :calculated_trim_spine

    attr_accessor :calculated_trim_face

    attr_accessor :bleed_size

    attr_accessor :act1_note

    attr_accessor :flat_size_h

    attr_accessor :tab_foot_display_uom

    attr_accessor :target_sell_price

    attr_accessor :num_sigs_odd_press_form

    attr_accessor :proof_part

    attr_accessor :print_stream_product_id

    attr_accessor :trim_size_width

    attr_accessor :printable_job_ticket_id

    attr_accessor :trim_foot

    attr_accessor :queue_destination

    attr_accessor :calculated_tab_face

    attr_accessor :iway_product_id

    attr_accessor :include_signatures_to_auto_count_collation

    attr_accessor :tab_head

    attr_accessor :act5_date_time

    attr_accessor :trim_face_display_uom

    attr_accessor :dsf_product_id

    attr_accessor :non_image_face_display_uom

    attr_accessor :page_delivery

    attr_accessor :invoice_w2_p_tax_amount

    attr_accessor :visual_opening_face

    attr_accessor :w2p_handling_amount

    attr_accessor :total_hours

    attr_accessor :bleeds_foot_display_uom

    attr_accessor :grain_specifications

    attr_accessor :cauto_key

    attr_accessor :tab_spine

    attr_accessor :visual_opening_foot

    attr_accessor :parallel_folds

    attr_accessor :use_basic_jacket

    attr_accessor :status_reason

    attr_accessor :qty_billed

    attr_accessor :item_to_replenish

    attr_accessor :status_comment

    attr_accessor :pending_billed_amt

    attr_accessor :last_status_changed_date_time

    attr_accessor :num_sep

    attr_accessor :calculated_trim_foot

    attr_accessor :fold_pattern_desc

    attr_accessor :tab_head_display_uom

    attr_accessor :calculated_bleeds_spine

    attr_accessor :jog_side

    attr_accessor :trim_foot_display_uom

    attr_accessor :act6_date_time

    attr_accessor :bleeds_face

    attr_accessor :non_image_spine

    attr_accessor :trim_head_display_uom

    attr_accessor :act4_note

    attr_accessor :total_cost

    attr_accessor :bleeds_spine_display_uom

    attr_accessor :print_stream_ticket_string

    attr_accessor :flat_size_w_display_uom

    attr_accessor :transaction_costs

    attr_accessor :act3_date_time

    attr_accessor :total_digital_black_and_white_pages

    attr_accessor :ink_desc_s1

    attr_accessor :ink_desc_s2

    attr_accessor :tab_face

    attr_accessor :invoice_w2_p_order_amount

    attr_accessor :seam_direction

    attr_accessor :mdff_order_item_status

    attr_accessor :desktop

    attr_accessor :calculated_back_overfold

    attr_accessor :last_act_code

    attr_accessor :last_co_dept

    attr_accessor :job_type

    attr_accessor :fiscal_week_ship

    attr_accessor :default_part

    attr_accessor :calculated_tab_head

    attr_accessor :non_image_spine_display_uom

    attr_accessor :last_act_date_time

    attr_accessor :trim_size_height

    attr_accessor :visual_opening_size_height

    attr_accessor :quote_per_m

    attr_accessor :no_schedule_before_ac

    attr_accessor :contour_perimeter

    attr_accessor :bindery_work

    attr_accessor :previous_job_ref

    attr_accessor :tab_foot

    attr_accessor :fiery_machine_properties

    attr_accessor :total_digital_color_pages

    attr_accessor :bill_uom

    attr_accessor :trim_head

    attr_accessor :pageflex_document_id

    attr_accessor :production_job_part

    attr_accessor :direct_mail_part

    attr_accessor :job_cost10

    attr_accessor :dsf_product_description

    attr_accessor :num_press_forms

    attr_accessor :margin_right

    attr_accessor :previous_created_by_connect

    attr_accessor :prev_fiery_make_ready_id

    attr_accessor :trim_spine

    attr_accessor :est_cost_per_m

    attr_accessor :fiery_central_state

    attr_accessor :plates

    attr_accessor :bleeds

    attr_accessor :created_by_connect

    attr_accessor :stitcher

    attr_accessor :invoice_w2_p_shipping_amount

    attr_accessor :allowances_changed

    attr_accessor :sheets_net_required

    attr_accessor :visual_opening_size_height_display_uom

    attr_accessor :bleeds_head_display_uom

    attr_accessor :act3_note

    attr_accessor :production_job

    attr_accessor :estimate_version

    attr_accessor :act4_date_time

    attr_accessor :calculated_tab_spine

    attr_accessor :trim_size_width_display_uom

    attr_accessor :bleeds_head

    attr_accessor :bleeds_spine

    attr_accessor :fiery_make_ready_id

    attr_accessor :sheets_off_press

    attr_accessor :user_defined1

    attr_accessor :prepress_workflow

    attr_accessor :line_item_id

    attr_accessor :tab_spine_display_uom

    attr_accessor :act1_date_time

    attr_accessor :mfg_group

    attr_accessor :calculated_bleeds_head

    attr_accessor :calculated_spine_size

    attr_accessor :estimator

    attr_accessor :num_ht

    attr_accessor :mdff_order_status

    attr_accessor :visual_opening_spine

    attr_accessor :folder_num_up

    attr_accessor :prep_quote_num

    attr_accessor :print_stream_product_description

    attr_accessor :tile_product

    attr_accessor :separate_layout

    attr_accessor :qty_picked

    attr_accessor :no_schedule_after_act

    attr_accessor :original_manufacturing_location

    attr_accessor :combined_into_job

    attr_accessor :printable_job_ticket

    attr_accessor :job_cost03

    attr_accessor :job_cost02

    attr_accessor :web_order_line

    attr_accessor :job_cost05

    attr_accessor :presentation_direction

    attr_accessor :job_cost04

    attr_accessor :job_cost07

    attr_accessor :calculated_num_odd_panels_width

    attr_accessor :job_cost06

    attr_accessor :job_cost09

    attr_accessor :job_cost08

    attr_accessor :press_sheet_num_out

    attr_accessor :use_press_forms

    attr_accessor :sides

    attr_accessor :bleeds_face_display_uom

    attr_accessor :co_total

    attr_accessor :act2_date_time

    attr_accessor :binding_side

    attr_accessor :trim_spine_display_uom

    attr_accessor :last_co_date_time

    attr_accessor :photos

    attr_accessor :gangable

    attr_accessor :network_folders_creation_message

    attr_accessor :jog_trim

    attr_accessor :production_status

    attr_accessor :grain

    attr_accessor :dsf_ticket_string

    attr_accessor :act6_note

    attr_accessor :jog_trim_display_uom

    attr_accessor :next_sequence

    attr_accessor :calculated_tab_foot

    attr_accessor :billed_extras_amt

    attr_accessor :cocount

    attr_accessor :invoice_w2_p_handling_amount

    attr_accessor :ship_to_job_contact

    attr_accessor :status_reason_comment

    attr_accessor :non_image_head

    attr_accessor :edit_date

    attr_accessor :contour_perimeter_uom

    attr_accessor :non_image_head_display_uom

    attr_accessor :quote_product

    attr_accessor :original_quoted_price_per_m_forced

    attr_accessor :billed_amt

    attr_accessor :margin_bottom

    attr_accessor :act2_note

    attr_accessor :transaction_hours

    attr_accessor :calculated_num_odd_panels_spine

    attr_accessor :data_purge_complete

    attr_accessor :load_balanced

    attr_accessor :dsf_item_id

    attr_accessor :job_part_version

    attr_accessor :control_gates_reviewed

    attr_accessor :sub_job_type

    attr_accessor :calculated_bleeds_face

    attr_accessor :actual_ship_date

    attr_accessor :visual_opening_size_width

    attr_accessor :trim_size_height_display_uom

    attr_accessor :flat_size_h_display_uom

    attr_accessor :press1

    attr_accessor :press2

    attr_accessor :calculated_bleeds_foot

    attr_accessor :margin_bottom_display_uom

    attr_accessor :tab_face_display_uom

    attr_accessor :num_plies

    attr_accessor :job_product_type

    attr_accessor :earliest_start_date_time

    attr_accessor :component_description

    attr_accessor :fiery_error_state

    attr_accessor :requires_imposition

    attr_accessor :bindery_method

    attr_accessor :production_job_part_key

    attr_accessor :margin_right_display_uom

    attr_accessor :previous_job_num

    attr_accessor :visual_opening_head

    attr_accessor :network_folders_created

    attr_accessor :original_quoted_price


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'value' => :'value',
        :'priority' => :'priority',
        :'certification_product_classification' => :'certificationProductClassification',
        :'colors' => :'colors',
        :'description' => :'description',
        :'visual_opening_size_width_display_uom' => :'visualOpeningSizeWidthDisplayUOM',
        :'job_cost01' => :'jobCost01',
        :'include_mailing' => :'includeMailing',
        :'qty_to_mfg' => :'qtyToMfg',
        :'num_prs_shts_out' => :'numPrsShtsOut',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'primary_key' => :'primaryKey',
        :'invoice_date' => :'invoiceDate',
        :'content_file' => :'contentFile',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sales_category' => :'salesCategory',
        :'plant_manager_id' => :'plantManagerId',
        :'certification_authority' => :'certificationAuthority',
        :'bill_rate' => :'billRate',
        :'certification_level' => :'certificationLevel',
        :'contact_num' => :'contactNum',
        :'tax_category' => :'taxCategory',
        :'ship_to_contact' => :'shipToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'item_template' => :'itemTemplate',
        :'date_time_setup' => :'dateTimeSetup',
        :'estimate_part' => :'estimatePart',
        :'quoted_price' => :'quotedPrice',
        :'quoted_price_forced' => :'quotedPriceForced',
        :'job_product' => :'jobProduct',
        :'outside_purchase_workflow' => :'outsidePurchaseWorkflow',
        :'folder' => :'folder',
        :'production_type' => :'productionType',
        :'non_planned_reason' => :'nonPlannedReason',
        :'additional_description' => :'additionalDescription',
        :'product' => :'product',
        :'estimate' => :'estimate',
        :'user_interface_set' => :'userInterfaceSet',
        :'final_size_w' => :'finalSizeW',
        :'colors_s2' => :'colorsS2',
        :'colors_s1' => :'colorsS1',
        :'final_size_w_display_uom' => :'finalSizeWDisplayUOM',
        :'final_size_h' => :'finalSizeH',
        :'num_sigs' => :'numSigs',
        :'final_size_h_display_uom' => :'finalSizeHDisplayUOM',
        :'colors_total' => :'colorsTotal',
        :'qty_ordered' => :'qtyOrdered',
        :'routing_template' => :'routingTemplate',
        :'speed_factor' => :'speedFactor',
        :'estimated_cost' => :'estimatedCost',
        :'metrix_enabled' => :'metrixEnabled',
        :'calculating' => :'calculating',
        :'odd_panel_spine_size' => :'oddPanelSpineSize',
        :'odd_panel_width_size_display_uom' => :'oddPanelWidthSizeDisplayUOM',
        :'odd_panel_spine_size_display_uom' => :'oddPanelSpineSizeDisplayUOM',
        :'fold_pattern_key' => :'foldPatternKey',
        :'virtual_printer' => :'virtualPrinter',
        :'due_date_time' => :'dueDateTime',
        :'run_method' => :'runMethod',
        :'qty_shipped' => :'qtyShipped',
        :'output_resource_id' => :'outputResourceID',
        :'quantity_remaining' => :'quantityRemaining',
        :'printable_order_detail_id' => :'printableOrderDetailID',
        :'metrix_component_id' => :'metrixComponentID',
        :'pace_connect_file_name' => :'paceConnectFileName',
        :'process_status' => :'processStatus',
        :'run' => :'run',
        :'scheduled_flag' => :'scheduledFlag',
        :'jdf_submitted' => :'jdfSubmitted',
        :'fold_pattern' => :'foldPattern',
        :'pages' => :'pages',
        :'job_contact' => :'jobContact',
        :'pace_connect_file_type' => :'paceConnectFileType',
        :'print_run_method' => :'printRunMethod',
        :'pace_connect_url' => :'paceConnectURL',
        :'pattern_category' => :'patternCategory',
        :'form_num' => :'formNum',
        :'metrix_id' => :'metrixID',
        :'scheduled' => :'scheduled',
        :'queue_entry_id' => :'queueEntryID',
        :'use_legacy_print_flow_format' => :'useLegacyPrintFlowFormat',
        :'pace_connect_file_size' => :'paceConnectFileSize',
        :'odd_panel_width_size' => :'oddPanelWidthSize',
        :'num_odd_panels_spine' => :'numOddPanelsSpine',
        :'num_odd_panels_width' => :'numOddPanelsWidth',
        :'print_stream_item_id' => :'printStreamItemID',
        :'sheets_to_press' => :'sheetsToPress',
        :'stitcher_num_up' => :'stitcherNumUp',
        :'lock_sales_dists' => :'lockSalesDists',
        :'calculated_odd_panel_width_size' => :'calculatedOddPanelWidthSize',
        :'finished_auto_import' => :'finishedAutoImport',
        :'shipping_workflow' => :'shippingWorkflow',
        :'spine_size_display_uom' => :'spineSizeDisplayUOM',
        :'resolution' => :'resolution',
        :'w2p_shipping_amount' => :'w2pShippingAmount',
        :'original_quoted_price_forced' => :'originalQuotedPriceForced',
        :'collate_on_printer' => :'collateOnPrinter',
        :'other_press_work' => :'otherPressWork',
        :'prep' => :'prep',
        :'proof_required' => :'proofRequired',
        :'spine_size' => :'spineSize',
        :'w2p_tax_amount' => :'w2pTaxAmount',
        :'calculated_front_overfold' => :'calculatedFrontOverfold',
        :'material_provided' => :'materialProvided',
        :'act5_note' => :'act5Note',
        :'non_image_face' => :'nonImageFace',
        :'calculated_trim_head' => :'calculatedTrimHead',
        :'mxml_layout_invalid' => :'mxmlLayoutInvalid',
        :'reading_direction' => :'readingDirection',
        :'right_folds' => :'rightFolds',
        :'bleeds_across' => :'bleedsAcross',
        :'bleeds_along' => :'bleedsAlong',
        :'freight_amt' => :'freightAmt',
        :'proofs' => :'proofs',
        :'gripper_color_bar' => :'gripperColorBar',
        :'calculated_odd_panel_spine_size' => :'calculatedOddPanelSpineSize',
        :'invoice_sequence' => :'invoiceSequence',
        :'non_image_foot' => :'nonImageFoot',
        :'non_image_foot_display_uom' => :'nonImageFootDisplayUOM',
        :'original_quoted_price_per_m' => :'originalQuotedPricePerM',
        :'trim_face' => :'trimFace',
        :'total_digital_pages' => :'totalDigitalPages',
        :'bleeds_foot' => :'bleedsFoot',
        :'bleed_size_display_uom' => :'bleedSizeDisplayUOM',
        :'flat_size_w' => :'flatSizeW',
        :'fiscal_week_set' => :'fiscalWeekSet',
        :'job_part_import_id' => :'jobPartImportID',
        :'calculated_trim_spine' => :'calculatedTrimSpine',
        :'calculated_trim_face' => :'calculatedTrimFace',
        :'bleed_size' => :'bleedSize',
        :'act1_note' => :'act1Note',
        :'flat_size_h' => :'flatSizeH',
        :'tab_foot_display_uom' => :'tabFootDisplayUOM',
        :'target_sell_price' => :'targetSellPrice',
        :'num_sigs_odd_press_form' => :'numSigsOddPressForm',
        :'proof_part' => :'proofPart',
        :'print_stream_product_id' => :'printStreamProductID',
        :'trim_size_width' => :'trimSizeWidth',
        :'printable_job_ticket_id' => :'printableJobTicketId',
        :'trim_foot' => :'trimFoot',
        :'queue_destination' => :'queueDestination',
        :'calculated_tab_face' => :'calculatedTabFace',
        :'iway_product_id' => :'iwayProductID',
        :'include_signatures_to_auto_count_collation' => :'includeSignaturesToAutoCountCollation',
        :'tab_head' => :'tabHead',
        :'act5_date_time' => :'act5DateTime',
        :'trim_face_display_uom' => :'trimFaceDisplayUOM',
        :'dsf_product_id' => :'dsfProductID',
        :'non_image_face_display_uom' => :'nonImageFaceDisplayUOM',
        :'page_delivery' => :'pageDelivery',
        :'invoice_w2_p_tax_amount' => :'invoiceW2PTaxAmount',
        :'visual_opening_face' => :'visualOpeningFace',
        :'w2p_handling_amount' => :'w2pHandlingAmount',
        :'total_hours' => :'totalHours',
        :'bleeds_foot_display_uom' => :'bleedsFootDisplayUOM',
        :'grain_specifications' => :'grainSpecifications',
        :'cauto_key' => :'cautoKey',
        :'tab_spine' => :'tabSpine',
        :'visual_opening_foot' => :'visualOpeningFoot',
        :'parallel_folds' => :'parallelFolds',
        :'use_basic_jacket' => :'useBasicJacket',
        :'status_reason' => :'statusReason',
        :'qty_billed' => :'qtyBilled',
        :'item_to_replenish' => :'itemToReplenish',
        :'status_comment' => :'statusComment',
        :'pending_billed_amt' => :'pendingBilledAmt',
        :'last_status_changed_date_time' => :'lastStatusChangedDateTime',
        :'num_sep' => :'numSep',
        :'calculated_trim_foot' => :'calculatedTrimFoot',
        :'fold_pattern_desc' => :'foldPatternDesc',
        :'tab_head_display_uom' => :'tabHeadDisplayUOM',
        :'calculated_bleeds_spine' => :'calculatedBleedsSpine',
        :'jog_side' => :'jogSide',
        :'trim_foot_display_uom' => :'trimFootDisplayUOM',
        :'act6_date_time' => :'act6DateTime',
        :'bleeds_face' => :'bleedsFace',
        :'non_image_spine' => :'nonImageSpine',
        :'trim_head_display_uom' => :'trimHeadDisplayUOM',
        :'act4_note' => :'act4Note',
        :'total_cost' => :'totalCost',
        :'bleeds_spine_display_uom' => :'bleedsSpineDisplayUOM',
        :'print_stream_ticket_string' => :'printStreamTicketString',
        :'flat_size_w_display_uom' => :'flatSizeWDisplayUOM',
        :'transaction_costs' => :'transactionCosts',
        :'act3_date_time' => :'act3DateTime',
        :'total_digital_black_and_white_pages' => :'totalDigitalBlackAndWhitePages',
        :'ink_desc_s1' => :'inkDescS1',
        :'ink_desc_s2' => :'inkDescS2',
        :'tab_face' => :'tabFace',
        :'invoice_w2_p_order_amount' => :'invoiceW2POrderAmount',
        :'seam_direction' => :'seamDirection',
        :'mdff_order_item_status' => :'mdffOrderItemStatus',
        :'desktop' => :'desktop',
        :'calculated_back_overfold' => :'calculatedBackOverfold',
        :'last_act_code' => :'lastActCode',
        :'last_co_dept' => :'lastCODept',
        :'job_type' => :'jobType',
        :'fiscal_week_ship' => :'fiscalWeekShip',
        :'default_part' => :'defaultPart',
        :'calculated_tab_head' => :'calculatedTabHead',
        :'non_image_spine_display_uom' => :'nonImageSpineDisplayUOM',
        :'last_act_date_time' => :'lastActDateTime',
        :'trim_size_height' => :'trimSizeHeight',
        :'visual_opening_size_height' => :'visualOpeningSizeHeight',
        :'quote_per_m' => :'quotePerM',
        :'no_schedule_before_ac' => :'noScheduleBeforeAc',
        :'contour_perimeter' => :'contourPerimeter',
        :'bindery_work' => :'binderyWork',
        :'previous_job_ref' => :'previousJobRef',
        :'tab_foot' => :'tabFoot',
        :'fiery_machine_properties' => :'fieryMachineProperties',
        :'total_digital_color_pages' => :'totalDigitalColorPages',
        :'bill_uom' => :'billUOM',
        :'trim_head' => :'trimHead',
        :'pageflex_document_id' => :'pageflexDocumentID',
        :'production_job_part' => :'productionJobPart',
        :'direct_mail_part' => :'directMailPart',
        :'job_cost10' => :'jobCost10',
        :'dsf_product_description' => :'dsfProductDescription',
        :'num_press_forms' => :'numPressForms',
        :'margin_right' => :'marginRight',
        :'previous_created_by_connect' => :'previousCreatedByConnect',
        :'prev_fiery_make_ready_id' => :'prevFieryMakeReadyID',
        :'trim_spine' => :'trimSpine',
        :'est_cost_per_m' => :'estCostPerM',
        :'fiery_central_state' => :'fieryCentralState',
        :'plates' => :'plates',
        :'bleeds' => :'bleeds',
        :'created_by_connect' => :'createdByConnect',
        :'stitcher' => :'stitcher',
        :'invoice_w2_p_shipping_amount' => :'invoiceW2PShippingAmount',
        :'allowances_changed' => :'allowancesChanged',
        :'sheets_net_required' => :'sheetsNetRequired',
        :'visual_opening_size_height_display_uom' => :'visualOpeningSizeHeightDisplayUOM',
        :'bleeds_head_display_uom' => :'bleedsHeadDisplayUOM',
        :'act3_note' => :'act3Note',
        :'production_job' => :'productionJob',
        :'estimate_version' => :'estimateVersion',
        :'act4_date_time' => :'act4DateTime',
        :'calculated_tab_spine' => :'calculatedTabSpine',
        :'trim_size_width_display_uom' => :'trimSizeWidthDisplayUOM',
        :'bleeds_head' => :'bleedsHead',
        :'bleeds_spine' => :'bleedsSpine',
        :'fiery_make_ready_id' => :'fieryMakeReadyID',
        :'sheets_off_press' => :'sheetsOffPress',
        :'user_defined1' => :'userDefined1',
        :'prepress_workflow' => :'prepressWorkflow',
        :'line_item_id' => :'lineItemID',
        :'tab_spine_display_uom' => :'tabSpineDisplayUOM',
        :'act1_date_time' => :'act1DateTime',
        :'mfg_group' => :'mfgGroup',
        :'calculated_bleeds_head' => :'calculatedBleedsHead',
        :'calculated_spine_size' => :'calculatedSpineSize',
        :'estimator' => :'estimator',
        :'num_ht' => :'numHT',
        :'mdff_order_status' => :'mdffOrderStatus',
        :'visual_opening_spine' => :'visualOpeningSpine',
        :'folder_num_up' => :'folderNumUp',
        :'prep_quote_num' => :'prepQuoteNum',
        :'print_stream_product_description' => :'printStreamProductDescription',
        :'tile_product' => :'tileProduct',
        :'separate_layout' => :'separateLayout',
        :'qty_picked' => :'qtyPicked',
        :'no_schedule_after_act' => :'noScheduleAfterAct',
        :'original_manufacturing_location' => :'originalManufacturingLocation',
        :'combined_into_job' => :'combinedIntoJob',
        :'printable_job_ticket' => :'printableJobTicket',
        :'job_cost03' => :'jobCost03',
        :'job_cost02' => :'jobCost02',
        :'web_order_line' => :'webOrderLine',
        :'job_cost05' => :'jobCost05',
        :'presentation_direction' => :'presentationDirection',
        :'job_cost04' => :'jobCost04',
        :'job_cost07' => :'jobCost07',
        :'calculated_num_odd_panels_width' => :'calculatedNumOddPanelsWidth',
        :'job_cost06' => :'jobCost06',
        :'job_cost09' => :'jobCost09',
        :'job_cost08' => :'jobCost08',
        :'press_sheet_num_out' => :'pressSheetNumOut',
        :'use_press_forms' => :'usePressForms',
        :'sides' => :'sides',
        :'bleeds_face_display_uom' => :'bleedsFaceDisplayUOM',
        :'co_total' => :'coTotal',
        :'act2_date_time' => :'act2DateTime',
        :'binding_side' => :'bindingSide',
        :'trim_spine_display_uom' => :'trimSpineDisplayUOM',
        :'last_co_date_time' => :'lastCODateTime',
        :'photos' => :'photos',
        :'gangable' => :'gangable',
        :'network_folders_creation_message' => :'networkFoldersCreationMessage',
        :'jog_trim' => :'jogTrim',
        :'production_status' => :'productionStatus',
        :'grain' => :'grain',
        :'dsf_ticket_string' => :'dsfTicketString',
        :'act6_note' => :'act6Note',
        :'jog_trim_display_uom' => :'jogTrimDisplayUOM',
        :'next_sequence' => :'nextSequence',
        :'calculated_tab_foot' => :'calculatedTabFoot',
        :'billed_extras_amt' => :'billedExtrasAmt',
        :'cocount' => :'cocount',
        :'invoice_w2_p_handling_amount' => :'invoiceW2PHandlingAmount',
        :'ship_to_job_contact' => :'shipToJobContact',
        :'status_reason_comment' => :'statusReasonComment',
        :'non_image_head' => :'nonImageHead',
        :'edit_date' => :'editDate',
        :'contour_perimeter_uom' => :'contourPerimeterUOM',
        :'non_image_head_display_uom' => :'nonImageHeadDisplayUOM',
        :'quote_product' => :'quoteProduct',
        :'original_quoted_price_per_m_forced' => :'originalQuotedPricePerMForced',
        :'billed_amt' => :'billedAmt',
        :'margin_bottom' => :'marginBottom',
        :'act2_note' => :'act2Note',
        :'transaction_hours' => :'transactionHours',
        :'calculated_num_odd_panels_spine' => :'calculatedNumOddPanelsSpine',
        :'data_purge_complete' => :'dataPurgeComplete',
        :'load_balanced' => :'loadBalanced',
        :'dsf_item_id' => :'dsfItemID',
        :'job_part_version' => :'jobPartVersion',
        :'control_gates_reviewed' => :'controlGatesReviewed',
        :'sub_job_type' => :'subJobType',
        :'calculated_bleeds_face' => :'calculatedBleedsFace',
        :'actual_ship_date' => :'actualShipDate',
        :'visual_opening_size_width' => :'visualOpeningSizeWidth',
        :'trim_size_height_display_uom' => :'trimSizeHeightDisplayUOM',
        :'flat_size_h_display_uom' => :'flatSizeHDisplayUOM',
        :'press1' => :'press1',
        :'press2' => :'press2',
        :'calculated_bleeds_foot' => :'calculatedBleedsFoot',
        :'margin_bottom_display_uom' => :'marginBottomDisplayUOM',
        :'tab_face_display_uom' => :'tabFaceDisplayUOM',
        :'num_plies' => :'numPlies',
        :'job_product_type' => :'jobProductType',
        :'earliest_start_date_time' => :'earliestStartDateTime',
        :'component_description' => :'componentDescription',
        :'fiery_error_state' => :'fieryErrorState',
        :'requires_imposition' => :'requiresImposition',
        :'bindery_method' => :'binderyMethod',
        :'production_job_part_key' => :'productionJobPartKey',
        :'margin_right_display_uom' => :'marginRightDisplayUOM',
        :'previous_job_num' => :'previousJobNum',
        :'visual_opening_head' => :'visualOpeningHead',
        :'network_folders_created' => :'networkFoldersCreated',
        :'original_quoted_price' => :'originalQuotedPrice'
      }
    end
  end
end
