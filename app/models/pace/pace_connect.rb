module Pace
  class PaceConnect < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :type

    attr_accessor :object

    attr_accessor :debug

    attr_accessor :active

    attr_accessor :count

    attr_accessor :version

    attr_accessor :xml_standalone

    attr_accessor :description

    attr_accessor :xml_encoding

    attr_accessor :task_quantity_expression

    attr_accessor :only_send_task_and_run_queue_on_job_plan_updates

    attr_accessor :output_file_name

    attr_accessor :display_catalog_management_buttons

    attr_accessor :max_retries_incoming

    attr_accessor :license

    attr_accessor :visible

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :object_filter

    attr_accessor :system_generated

    attr_accessor :customer_group

    attr_accessor :lead_time

    attr_accessor :customer

    attr_accessor :vendor

    attr_accessor :email_template

    attr_accessor :overwrite_files_in_output_location

    attr_accessor :default_activity_code

    attr_accessor :maximum_execution_results_to_store

    attr_accessor :job_description

    attr_accessor :file_suffix

    attr_accessor :file_prefix

    attr_accessor :velocity_template

    attr_accessor :file_name_expression

    attr_accessor :export_type

    attr_accessor :import_template

    attr_accessor :print_stream_partial_shipment

    attr_accessor :default_customer

    attr_accessor :job_part_description

    attr_accessor :default_shipment_type

    attr_accessor :default_job_type

    attr_accessor :job_product_description

    attr_accessor :print_flow_job_due_date

    attr_accessor :related_connect

    attr_accessor :pull_item_template_id_from

    attr_accessor :accept_new_jdf

    attr_accessor :file_ext

    attr_accessor :update_planning

    attr_accessor :last_run_time_in_millis

    attr_accessor :eflow_topic_version

    attr_accessor :allow_duplicate_mapping_values

    attr_accessor :authorization_token

    attr_accessor :sync_enabled

    attr_accessor :default_proof_back_hours

    attr_accessor :default_sheet_material_inventory_item

    attr_accessor :default_shipment_type2

    attr_accessor :include_already_exported

    attr_accessor :routing_identifier

    attr_accessor :send_efi_properties

    attr_accessor :import_files_only_with_extension

    attr_accessor :jdf_connect

    attr_accessor :include_date_time_stamp

    attr_accessor :banner_sheet_report

    attr_accessor :export_component_attribute_name

    attr_accessor :supplier_id

    attr_accessor :promo_code_invoice_extra_type

    attr_accessor :eflow_metrix_license_name

    attr_accessor :send_update_on_job_version_change

    attr_accessor :export_catalog_items_batch_size

    attr_accessor :use_native_files

    attr_accessor :last_plant_manager_import

    attr_accessor :iway_item_template_identifier

    attr_accessor :external_company_id

    attr_accessor :last_run_time

    attr_accessor :ansi_receiver_id

    attr_accessor :default_contact2

    attr_accessor :default_contact1

    attr_accessor :tax_situs_rule

    attr_accessor :dsf_license_mode

    attr_accessor :auto_post_deposits

    attr_accessor :no_activity_monitor_schedule

    attr_accessor :device

    attr_accessor :export_vendor_id

    attr_accessor :force_second_estimate_recalculation

    attr_accessor :execution_url

    attr_accessor :media_namespaces

    attr_accessor :process_materials

    attr_accessor :url_space_encoding

    attr_accessor :invoice_selection

    attr_accessor :message_interval

    attr_accessor :site_guid

    attr_accessor :create_cartons

    attr_accessor :no_activity_email

    attr_accessor :rejected_shipment_type

    attr_accessor :format_field_values

    attr_accessor :bol_cancel_shipment_type

    attr_accessor :default_user

    attr_accessor :plant_manager_task_description

    attr_accessor :embed_subscription_in_submit

    attr_accessor :client_id

    attr_accessor :send_to_auto_count_per_plan

    attr_accessor :web_service_user_name

    attr_accessor :validate_inputs

    attr_accessor :use_e_flow

    attr_accessor :frequency_outgoing

    attr_accessor :use_content_file_name_in_jdf

    attr_accessor :job_part_only

    attr_accessor :dsf_handling_fee

    attr_accessor :use_static_time_range

    attr_accessor :process_shipper_final_shipment

    attr_accessor :redirect_url

    attr_accessor :default_job_type_print_part

    attr_accessor :file_encoding

    attr_accessor :job_product_description_for_bod

    attr_accessor :error_response_handling_instruction

    attr_accessor :use_quantity_to_produce

    attr_accessor :default_roll_material_inventory_item

    attr_accessor :agfa_add_product_idin_job_id

    attr_accessor :maximum_automatic_execution_attempts

    attr_accessor :hp_send_unmapped_media

    attr_accessor :completed_job_status

    attr_accessor :print_stream_discounts

    attr_accessor :process_pagination_data

    attr_accessor :iway_map_job_id

    attr_accessor :etrading_partner_id

    attr_accessor :banner_sheet_connect

    attr_accessor :input_file_name

    attr_accessor :default_job_product_type

    attr_accessor :force_quoted_price

    attr_accessor :page_to_bleed_gap

    attr_accessor :default_ask_quantity_multiplier

    attr_accessor :org_id

    attr_accessor :kit_job_type

    attr_accessor :default_freight_markup

    attr_accessor :dsf_promo_code

    attr_accessor :show_dsf_entities

    attr_accessor :maximum_job_parts_to_import

    attr_accessor :plant_manager_plant_id

    attr_accessor :embed_new_jdf

    attr_accessor :process_labor

    attr_accessor :use_bod_for_inventory_items

    attr_accessor :attach_xpath_note

    attr_accessor :mta_pace_ip

    attr_accessor :dsf_discounts

    attr_accessor :use_sequential_signature_and_sheet_name

    attr_accessor :delete_failed_files_in_input_location

    attr_accessor :proof_on_hold_job_part_status

    attr_accessor :vertex_trusted_id

    attr_accessor :include_actual_ship_costs

    attr_accessor :data_element_separator

    attr_accessor :local_tax_connector_deployed

    attr_accessor :parts_threshold

    attr_accessor :send_event_messages_in_sequence

    attr_accessor :ignore_zero_price_and_quantity_printservices

    attr_accessor :maximum_concurrent_outgoing_executions

    attr_accessor :mdff_integration

    attr_accessor :use_persistent_queue

    attr_accessor :export_customer_id

    attr_accessor :job_convert_options

    attr_accessor :app_name

    attr_accessor :iway_map_order_id

    attr_accessor :failed_event_handler

    attr_accessor :external_freight_code

    attr_accessor :failed_status

    attr_accessor :client_number

    attr_accessor :default_cost_center

    attr_accessor :default_press

    attr_accessor :process_completed_signals

    attr_accessor :time_out

    attr_accessor :vertex_origin_tax_area_id

    attr_accessor :schedule

    attr_accessor :page_to_bleed_gap_display_uom

    attr_accessor :segment_terminator

    attr_accessor :partition_scheme

    attr_accessor :include_headings

    attr_accessor :mixed_media_page_range_click_expression

    attr_accessor :auto_refresh_events

    attr_accessor :mta_content_computer_name

    attr_accessor :validate_outputs

    attr_accessor :retry_schedule

    attr_accessor :warning_event_handler

    attr_accessor :include_job_part_id_in_queries

    attr_accessor :validation_key

    attr_accessor :remove_non_syncronized_objects

    attr_accessor :plant_manager_run_queue_description

    attr_accessor :purge_data_delay_hours

    attr_accessor :delimiter

    attr_accessor :mta_content_path

    attr_accessor :results_house_keeper_schedule

    attr_accessor :dispatch_machine_events

    attr_accessor :page_range_click_expression

    attr_accessor :purge_data_job_status

    attr_accessor :time_range

    attr_accessor :embed_status_query

    attr_accessor :job_description2_for_bod

    attr_accessor :component_element_separator

    attr_accessor :print_stream_final_shipment

    attr_accessor :send_page_ranges

    attr_accessor :time_pad

    attr_accessor :auto_pay_invoices

    attr_accessor :regulatory_code

    attr_accessor :calculate_press_form_level_fields

    attr_accessor :four51_item_template_identifier

    attr_accessor :default_srjde_code

    attr_accessor :check_total_syncronized_objects

    attr_accessor :maximum_concurrent_incoming_executions

    attr_accessor :print_stream_handling_charge

    attr_accessor :web_service_url2

    attr_accessor :default_department

    attr_accessor :email_results

    attr_accessor :auto_accept_layout

    attr_accessor :file_name_reg_ex

    attr_accessor :default_item_template

    attr_accessor :validation_rejected_status

    attr_accessor :ignore_events_from_object_import

    attr_accessor :maximum_concurrent_executions

    attr_accessor :order_rejected_job_part_status

    attr_accessor :receiver_profile_id_type

    attr_accessor :comment_url_type

    attr_accessor :default_thumbnail_attachment_category

    attr_accessor :send_na_vision_current_date

    attr_accessor :email_sales_person

    attr_accessor :external_handling_charge_code

    attr_accessor :use_estimating_paper_rounding

    attr_accessor :execution_priority

    attr_accessor :banner_sheet_inventory_item

    attr_accessor :default_wide_format_press

    attr_accessor :threshold_range_for_execution

    attr_accessor :order_accepted_job_part_status

    attr_accessor :web_service_password

    attr_accessor :job_description2

    attr_accessor :record_successful_results

    attr_accessor :web_service_url

    attr_accessor :enter_deposit

    attr_accessor :macola_tax_code

    attr_accessor :success_event_handler

    attr_accessor :remove_exported_objects

    attr_accessor :integrate_handling_taxation

    attr_accessor :token

    attr_accessor :crm_user

    attr_accessor :seller_company

    attr_accessor :export_velocity_template

    attr_accessor :ansi_sender_id

    attr_accessor :merchant_account

    attr_accessor :debug_transactions

    attr_accessor :database_connection

    attr_accessor :print_flow_web_punch_out_time_tolerance

    attr_accessor :default_job_type_fin_goods_part

    attr_accessor :refresh_job_plan_after_import

    attr_accessor :no_activity_timeout

    attr_accessor :seller_division

    attr_accessor :plant_manager_job_description

    attr_accessor :dynamic_promise_date_time

    attr_accessor :automated_workflow

    attr_accessor :default_job_status

    attr_accessor :merge_metrix_jdf

    attr_accessor :sales_type_code

    attr_accessor :delete_imported_files_in_input_location

    attr_accessor :sender_profile_id_type

    attr_accessor :validation_accepted_status

    attr_accessor :default_sr_freight_jde_code

    attr_accessor :create_shipments_upon_order_receipt

    attr_accessor :default_tax_report

    attr_accessor :dsf_other

    attr_accessor :require_due_date_on_export

    attr_accessor :client_secret

    attr_accessor :email_csr

    attr_accessor :handling_invoice_extra_type

    attr_accessor :default_show_on_invoice_if_zero_dollars

    attr_accessor :output_format

    attr_accessor :job_description_for_bod

    attr_accessor :attach_xpath_desc

    attr_accessor :ack_transaction_type

    attr_accessor :default_shipment_time

    attr_accessor :dsf_setup_fee

    attr_accessor :suppress_pids

    attr_accessor :process_paper

    attr_accessor :days_to_store_pending_file

    attr_accessor :default_activity_code2

    attr_accessor :comment_url_report

    attr_accessor :default_activity_code3

    attr_accessor :default_activity_code4

    attr_accessor :last_plant_manager_status_update

    attr_accessor :estimated_shipping_invoice_extra_type

    attr_accessor :xslt_style_sheet

    attr_accessor :route_jobs_to_manufacturing_location

    attr_accessor :sync_interval_minutes

    attr_accessor :job_part_description_for_bod

    attr_accessor :production_status_check_required

    attr_accessor :cancelled_job_part_status

    attr_accessor :default_run_insert_inventory_item

    attr_accessor :pace_connect_pending_file_time_out

    attr_accessor :send_device_subscriptions

    attr_accessor :jdf_version

    attr_accessor :failed_delete_job_part_status

    attr_accessor :dsf_rush_fee

    attr_accessor :pull_job_part_description_from

    attr_accessor :removed_from_schedule_prod_status

    attr_accessor :receiver_profile_id

    attr_accessor :use_metrix_finishing_groups

    attr_accessor :printing_department

    attr_accessor :maximum_queued_executions

    attr_accessor :scheduled_prod_status

    attr_accessor :xml_declaration

    attr_accessor :rescheduled_prod_status

    attr_accessor :default_days

    attr_accessor :global_subscription_on

    attr_accessor :support_single_sign_on

    attr_accessor :frequency_incoming

    attr_accessor :facility_name

    attr_accessor :record_warnings_and_continue

    attr_accessor :intermediate_export_file_extension

    attr_accessor :report_id

    attr_accessor :max_retries_outgoing

    attr_accessor :print_stream_freight_charge

    attr_accessor :default_sales_category

    attr_accessor :ignore_manufacturing_location_change_from_print_flow

    attr_accessor :iway_single_shipment

    attr_accessor :jmf_queue_status_filter

    attr_accessor :comment_url_report_package

    attr_accessor :batch_size

    attr_accessor :include_finishing_make_ready_sheets_on_all_press_forms


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'type' => :'type',
        :'object' => :'object',
        :'debug' => :'debug',
        :'active' => :'active',
        :'count' => :'count',
        :'version' => :'version',
        :'xml_standalone' => :'xmlStandalone',
        :'description' => :'description',
        :'xml_encoding' => :'xmlEncoding',
        :'task_quantity_expression' => :'taskQuantityExpression',
        :'only_send_task_and_run_queue_on_job_plan_updates' => :'onlySendTaskAndRunQueueOnJobPlanUpdates',
        :'output_file_name' => :'outputFileName',
        :'display_catalog_management_buttons' => :'displayCatalogManagementButtons',
        :'max_retries_incoming' => :'maxRetriesIncoming',
        :'license' => :'license',
        :'visible' => :'visible',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'object_filter' => :'objectFilter',
        :'system_generated' => :'systemGenerated',
        :'customer_group' => :'customerGroup',
        :'lead_time' => :'leadTime',
        :'customer' => :'customer',
        :'vendor' => :'vendor',
        :'email_template' => :'emailTemplate',
        :'overwrite_files_in_output_location' => :'overwriteFilesInOutputLocation',
        :'default_activity_code' => :'defaultActivityCode',
        :'maximum_execution_results_to_store' => :'maximumExecutionResultsToStore',
        :'job_description' => :'jobDescription',
        :'file_suffix' => :'fileSuffix',
        :'file_prefix' => :'filePrefix',
        :'velocity_template' => :'velocityTemplate',
        :'file_name_expression' => :'fileNameExpression',
        :'export_type' => :'exportType',
        :'import_template' => :'importTemplate',
        :'print_stream_partial_shipment' => :'printStreamPartialShipment',
        :'default_customer' => :'defaultCustomer',
        :'job_part_description' => :'jobPartDescription',
        :'default_shipment_type' => :'defaultShipmentType',
        :'default_job_type' => :'defaultJobType',
        :'job_product_description' => :'jobProductDescription',
        :'print_flow_job_due_date' => :'printFlowJobDueDate',
        :'related_connect' => :'relatedConnect',
        :'pull_item_template_id_from' => :'pullItemTemplateIDFrom',
        :'accept_new_jdf' => :'acceptNewJDF',
        :'file_ext' => :'fileExt',
        :'update_planning' => :'updatePlanning',
        :'last_run_time_in_millis' => :'lastRunTimeInMillis',
        :'eflow_topic_version' => :'eflowTopicVersion',
        :'allow_duplicate_mapping_values' => :'allowDuplicateMappingValues',
        :'authorization_token' => :'authorizationToken',
        :'sync_enabled' => :'syncEnabled',
        :'default_proof_back_hours' => :'defaultProofBackHours',
        :'default_sheet_material_inventory_item' => :'defaultSheetMaterialInventoryItem',
        :'default_shipment_type2' => :'defaultShipmentType2',
        :'include_already_exported' => :'includeAlreadyExported',
        :'routing_identifier' => :'routingIdentifier',
        :'send_efi_properties' => :'sendEFIProperties',
        :'import_files_only_with_extension' => :'importFilesOnlyWithExtension',
        :'jdf_connect' => :'jdfConnect',
        :'include_date_time_stamp' => :'includeDateTimeStamp',
        :'banner_sheet_report' => :'bannerSheetReport',
        :'export_component_attribute_name' => :'exportComponentAttributeName',
        :'supplier_id' => :'supplierID',
        :'promo_code_invoice_extra_type' => :'promoCodeInvoiceExtraType',
        :'eflow_metrix_license_name' => :'eflowMetrixLicenseName',
        :'send_update_on_job_version_change' => :'sendUpdateOnJobVersionChange',
        :'export_catalog_items_batch_size' => :'exportCatalogItemsBatchSize',
        :'use_native_files' => :'useNativeFiles',
        :'last_plant_manager_import' => :'lastPlantManagerImport',
        :'iway_item_template_identifier' => :'iwayItemTemplateIdentifier',
        :'external_company_id' => :'externalCompanyId',
        :'last_run_time' => :'lastRunTime',
        :'ansi_receiver_id' => :'ansiReceiverId',
        :'default_contact2' => :'defaultContact2',
        :'default_contact1' => :'defaultContact1',
        :'tax_situs_rule' => :'taxSitusRule',
        :'dsf_license_mode' => :'dsfLicenseMode',
        :'auto_post_deposits' => :'autoPostDeposits',
        :'no_activity_monitor_schedule' => :'noActivityMonitorSchedule',
        :'device' => :'device',
        :'export_vendor_id' => :'exportVendorId',
        :'force_second_estimate_recalculation' => :'forceSecondEstimateRecalculation',
        :'execution_url' => :'executionUrl',
        :'media_namespaces' => :'mediaNamespaces',
        :'process_materials' => :'processMaterials',
        :'url_space_encoding' => :'urlSpaceEncoding',
        :'invoice_selection' => :'invoiceSelection',
        :'message_interval' => :'messageInterval',
        :'site_guid' => :'siteGuid',
        :'create_cartons' => :'createCartons',
        :'no_activity_email' => :'noActivityEmail',
        :'rejected_shipment_type' => :'rejectedShipmentType',
        :'format_field_values' => :'formatFieldValues',
        :'bol_cancel_shipment_type' => :'bolCancelShipmentType',
        :'default_user' => :'defaultUser',
        :'plant_manager_task_description' => :'plantManagerTaskDescription',
        :'embed_subscription_in_submit' => :'embedSubscriptionInSubmit',
        :'client_id' => :'clientId',
        :'send_to_auto_count_per_plan' => :'sendToAutoCountPerPlan',
        :'web_service_user_name' => :'webServiceUserName',
        :'validate_inputs' => :'validateInputs',
        :'use_e_flow' => :'useEFlow',
        :'frequency_outgoing' => :'frequencyOutgoing',
        :'use_content_file_name_in_jdf' => :'useContentFileNameInJDF',
        :'job_part_only' => :'jobPartOnly',
        :'dsf_handling_fee' => :'dsfHandlingFee',
        :'use_static_time_range' => :'useStaticTimeRange',
        :'process_shipper_final_shipment' => :'processShipperFinalShipment',
        :'redirect_url' => :'redirectUrl',
        :'default_job_type_print_part' => :'defaultJobTypePrintPart',
        :'file_encoding' => :'fileEncoding',
        :'job_product_description_for_bod' => :'jobProductDescriptionForBOD',
        :'error_response_handling_instruction' => :'errorResponseHandlingInstruction',
        :'use_quantity_to_produce' => :'useQuantityToProduce',
        :'default_roll_material_inventory_item' => :'defaultRollMaterialInventoryItem',
        :'agfa_add_product_idin_job_id' => :'agfaAddProductIDInJobID',
        :'maximum_automatic_execution_attempts' => :'maximumAutomaticExecutionAttempts',
        :'hp_send_unmapped_media' => :'hpSendUnmappedMedia',
        :'completed_job_status' => :'completedJobStatus',
        :'print_stream_discounts' => :'printStreamDiscounts',
        :'process_pagination_data' => :'processPaginationData',
        :'iway_map_job_id' => :'iwayMapJobID',
        :'etrading_partner_id' => :'etradingPartnerID',
        :'banner_sheet_connect' => :'bannerSheetConnect',
        :'input_file_name' => :'inputFileName',
        :'default_job_product_type' => :'defaultJobProductType',
        :'force_quoted_price' => :'forceQuotedPrice',
        :'page_to_bleed_gap' => :'pageToBleedGap',
        :'default_ask_quantity_multiplier' => :'defaultAskQuantityMultiplier',
        :'org_id' => :'orgID',
        :'kit_job_type' => :'kitJobType',
        :'default_freight_markup' => :'defaultFreightMarkup',
        :'dsf_promo_code' => :'dsfPromoCode',
        :'show_dsf_entities' => :'showDSFEntities',
        :'maximum_job_parts_to_import' => :'maximumJobPartsToImport',
        :'plant_manager_plant_id' => :'plantManagerPlantId',
        :'embed_new_jdf' => :'embedNewJDF',
        :'process_labor' => :'processLabor',
        :'use_bod_for_inventory_items' => :'useBODForInventoryItems',
        :'attach_xpath_note' => :'attachXpathNote',
        :'mta_pace_ip' => :'mtaPaceIP',
        :'dsf_discounts' => :'dsfDiscounts',
        :'use_sequential_signature_and_sheet_name' => :'useSequentialSignatureAndSheetName',
        :'delete_failed_files_in_input_location' => :'deleteFailedFilesInInputLocation',
        :'proof_on_hold_job_part_status' => :'proofOnHoldJobPartStatus',
        :'vertex_trusted_id' => :'vertexTrustedId',
        :'include_actual_ship_costs' => :'includeActualShipCosts',
        :'data_element_separator' => :'dataElementSeparator',
        :'local_tax_connector_deployed' => :'localTaxConnectorDeployed',
        :'parts_threshold' => :'partsThreshold',
        :'send_event_messages_in_sequence' => :'sendEventMessagesInSequence',
        :'ignore_zero_price_and_quantity_printservices' => :'ignoreZeroPriceAndQuantityPrintservices',
        :'maximum_concurrent_outgoing_executions' => :'maximumConcurrentOutgoingExecutions',
        :'mdff_integration' => :'mdffIntegration',
        :'use_persistent_queue' => :'usePersistentQueue',
        :'export_customer_id' => :'exportCustomerId',
        :'job_convert_options' => :'jobConvertOptions',
        :'app_name' => :'appName',
        :'iway_map_order_id' => :'iwayMapOrderID',
        :'failed_event_handler' => :'failedEventHandler',
        :'external_freight_code' => :'externalFreightCode',
        :'failed_status' => :'failedStatus',
        :'client_number' => :'clientNumber',
        :'default_cost_center' => :'defaultCostCenter',
        :'default_press' => :'defaultPress',
        :'process_completed_signals' => :'processCompletedSignals',
        :'time_out' => :'timeOut',
        :'vertex_origin_tax_area_id' => :'vertexOriginTaxAreaID',
        :'schedule' => :'schedule',
        :'page_to_bleed_gap_display_uom' => :'pageToBleedGapDisplayUOM',
        :'segment_terminator' => :'segmentTerminator',
        :'partition_scheme' => :'partitionScheme',
        :'include_headings' => :'includeHeadings',
        :'mixed_media_page_range_click_expression' => :'mixedMediaPageRangeClickExpression',
        :'auto_refresh_events' => :'autoRefreshEvents',
        :'mta_content_computer_name' => :'mtaContentComputerName',
        :'validate_outputs' => :'validateOutputs',
        :'retry_schedule' => :'retrySchedule',
        :'warning_event_handler' => :'warningEventHandler',
        :'include_job_part_id_in_queries' => :'includeJobPartIdInQueries',
        :'validation_key' => :'validationKey',
        :'remove_non_syncronized_objects' => :'removeNonSyncronizedObjects',
        :'plant_manager_run_queue_description' => :'plantManagerRunQueueDescription',
        :'purge_data_delay_hours' => :'purgeDataDelayHours',
        :'delimiter' => :'delimiter',
        :'mta_content_path' => :'mtaContentPath',
        :'results_house_keeper_schedule' => :'resultsHouseKeeperSchedule',
        :'dispatch_machine_events' => :'dispatchMachineEvents',
        :'page_range_click_expression' => :'pageRangeClickExpression',
        :'purge_data_job_status' => :'purgeDataJobStatus',
        :'time_range' => :'timeRange',
        :'embed_status_query' => :'embedStatusQuery',
        :'job_description2_for_bod' => :'jobDescription2ForBOD',
        :'component_element_separator' => :'componentElementSeparator',
        :'print_stream_final_shipment' => :'printStreamFinalShipment',
        :'send_page_ranges' => :'sendPageRanges',
        :'time_pad' => :'timePad',
        :'auto_pay_invoices' => :'autoPayInvoices',
        :'regulatory_code' => :'regulatoryCode',
        :'calculate_press_form_level_fields' => :'calculatePressFormLevelFields',
        :'four51_item_template_identifier' => :'four51ItemTemplateIdentifier',
        :'default_srjde_code' => :'defaultSRJDECode',
        :'check_total_syncronized_objects' => :'checkTotalSyncronizedObjects',
        :'maximum_concurrent_incoming_executions' => :'maximumConcurrentIncomingExecutions',
        :'print_stream_handling_charge' => :'printStreamHandlingCharge',
        :'web_service_url2' => :'webServiceUrl2',
        :'default_department' => :'defaultDepartment',
        :'email_results' => :'emailResults',
        :'auto_accept_layout' => :'autoAcceptLayout',
        :'file_name_reg_ex' => :'fileNameRegEx',
        :'default_item_template' => :'defaultItemTemplate',
        :'validation_rejected_status' => :'validationRejectedStatus',
        :'ignore_events_from_object_import' => :'ignoreEventsFromObjectImport',
        :'maximum_concurrent_executions' => :'maximumConcurrentExecutions',
        :'order_rejected_job_part_status' => :'orderRejectedJobPartStatus',
        :'receiver_profile_id_type' => :'receiverProfileIDType',
        :'comment_url_type' => :'commentURLType',
        :'default_thumbnail_attachment_category' => :'defaultThumbnailAttachmentCategory',
        :'send_na_vision_current_date' => :'sendNaVisionCurrentDate',
        :'email_sales_person' => :'emailSalesPerson',
        :'external_handling_charge_code' => :'externalHandlingChargeCode',
        :'use_estimating_paper_rounding' => :'useEstimatingPaperRounding',
        :'execution_priority' => :'executionPriority',
        :'banner_sheet_inventory_item' => :'bannerSheetInventoryItem',
        :'default_wide_format_press' => :'defaultWideFormatPress',
        :'threshold_range_for_execution' => :'thresholdRangeForExecution',
        :'order_accepted_job_part_status' => :'orderAcceptedJobPartStatus',
        :'web_service_password' => :'webServicePassword',
        :'job_description2' => :'jobDescription2',
        :'record_successful_results' => :'recordSuccessfulResults',
        :'web_service_url' => :'webServiceUrl',
        :'enter_deposit' => :'enterDeposit',
        :'macola_tax_code' => :'macolaTaxCode',
        :'success_event_handler' => :'successEventHandler',
        :'remove_exported_objects' => :'removeExportedObjects',
        :'integrate_handling_taxation' => :'integrateHandlingTaxation',
        :'token' => :'token',
        :'crm_user' => :'crmUser',
        :'seller_company' => :'sellerCompany',
        :'export_velocity_template' => :'exportVelocityTemplate',
        :'ansi_sender_id' => :'ansiSenderId',
        :'merchant_account' => :'merchantAccount',
        :'debug_transactions' => :'debugTransactions',
        :'database_connection' => :'databaseConnection',
        :'print_flow_web_punch_out_time_tolerance' => :'printFlowWebPunchOutTimeTolerance',
        :'default_job_type_fin_goods_part' => :'defaultJobTypeFinGoodsPart',
        :'refresh_job_plan_after_import' => :'refreshJobPlanAfterImport',
        :'no_activity_timeout' => :'noActivityTimeout',
        :'seller_division' => :'sellerDivision',
        :'plant_manager_job_description' => :'plantManagerJobDescription',
        :'dynamic_promise_date_time' => :'dynamicPromiseDateTime',
        :'automated_workflow' => :'automatedWorkflow',
        :'default_job_status' => :'defaultJobStatus',
        :'merge_metrix_jdf' => :'mergeMetrixJDF',
        :'sales_type_code' => :'salesTypeCode',
        :'delete_imported_files_in_input_location' => :'deleteImportedFilesInInputLocation',
        :'sender_profile_id_type' => :'senderProfileIDType',
        :'validation_accepted_status' => :'validationAcceptedStatus',
        :'default_sr_freight_jde_code' => :'defaultSRFreightJDECode',
        :'create_shipments_upon_order_receipt' => :'createShipmentsUponOrderReceipt',
        :'default_tax_report' => :'defaultTaxReport',
        :'dsf_other' => :'dsfOther',
        :'require_due_date_on_export' => :'requireDueDateOnExport',
        :'client_secret' => :'clientSecret',
        :'email_csr' => :'emailCSR',
        :'handling_invoice_extra_type' => :'handlingInvoiceExtraType',
        :'default_show_on_invoice_if_zero_dollars' => :'defaultShowOnInvoiceIfZeroDollars',
        :'output_format' => :'outputFormat',
        :'job_description_for_bod' => :'jobDescriptionForBOD',
        :'attach_xpath_desc' => :'attachXpathDesc',
        :'ack_transaction_type' => :'ackTransactionType',
        :'default_shipment_time' => :'defaultShipmentTime',
        :'dsf_setup_fee' => :'dsfSetupFee',
        :'suppress_pids' => :'suppressPids',
        :'process_paper' => :'processPaper',
        :'days_to_store_pending_file' => :'daysToStorePendingFile',
        :'default_activity_code2' => :'defaultActivityCode2',
        :'comment_url_report' => :'commentURLReport',
        :'default_activity_code3' => :'defaultActivityCode3',
        :'default_activity_code4' => :'defaultActivityCode4',
        :'last_plant_manager_status_update' => :'lastPlantManagerStatusUpdate',
        :'estimated_shipping_invoice_extra_type' => :'estimatedShippingInvoiceExtraType',
        :'xslt_style_sheet' => :'xsltStyleSheet',
        :'route_jobs_to_manufacturing_location' => :'routeJobsToManufacturingLocation',
        :'sync_interval_minutes' => :'syncIntervalMinutes',
        :'job_part_description_for_bod' => :'jobPartDescriptionForBOD',
        :'production_status_check_required' => :'productionStatusCheckRequired',
        :'cancelled_job_part_status' => :'cancelledJobPartStatus',
        :'default_run_insert_inventory_item' => :'defaultRunInsertInventoryItem',
        :'pace_connect_pending_file_time_out' => :'paceConnectPendingFileTimeOut',
        :'send_device_subscriptions' => :'sendDeviceSubscriptions',
        :'jdf_version' => :'jdfVersion',
        :'failed_delete_job_part_status' => :'failedDeleteJobPartStatus',
        :'dsf_rush_fee' => :'dsfRushFee',
        :'pull_job_part_description_from' => :'pullJobPartDescriptionFrom',
        :'removed_from_schedule_prod_status' => :'removedFromScheduleProdStatus',
        :'receiver_profile_id' => :'receiverProfileID',
        :'use_metrix_finishing_groups' => :'useMetrixFinishingGroups',
        :'printing_department' => :'printingDepartment',
        :'maximum_queued_executions' => :'maximumQueuedExecutions',
        :'scheduled_prod_status' => :'scheduledProdStatus',
        :'xml_declaration' => :'xmlDeclaration',
        :'rescheduled_prod_status' => :'rescheduledProdStatus',
        :'default_days' => :'defaultDays',
        :'global_subscription_on' => :'globalSubscriptionOn',
        :'support_single_sign_on' => :'supportSingleSignOn',
        :'frequency_incoming' => :'frequencyIncoming',
        :'facility_name' => :'facilityName',
        :'record_warnings_and_continue' => :'recordWarningsAndContinue',
        :'intermediate_export_file_extension' => :'intermediateExportFileExtension',
        :'report_id' => :'reportId',
        :'max_retries_outgoing' => :'maxRetriesOutgoing',
        :'print_stream_freight_charge' => :'printStreamFreightCharge',
        :'default_sales_category' => :'defaultSalesCategory',
        :'ignore_manufacturing_location_change_from_print_flow' => :'ignoreManufacturingLocationChangeFromPrintFlow',
        :'iway_single_shipment' => :'iwaySingleShipment',
        :'jmf_queue_status_filter' => :'jmfQueueStatusFilter',
        :'comment_url_report_package' => :'commentURLReportPackage',
        :'batch_size' => :'batchSize',
        :'include_finishing_make_ready_sheets_on_all_press_forms' => :'includeFinishingMakeReadySheetsOnAllPressForms'
      }
    end
  end
end
