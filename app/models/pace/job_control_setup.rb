module Pace
  class JobControlSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :network_location

    attr_accessor :integrate_with_scheduling

    attr_accessor :ship_job

    attr_accessor :ship_job_part_items_condition

    attr_accessor :combo_job_percentage_calculation_rounding_method

    attr_accessor :job_shipment_date_time_mapping

    attr_accessor :ship_job_condition

    attr_accessor :ship_products

    attr_accessor :proof_approved_status

    attr_accessor :default_freight_on_board

    attr_accessor :proof_note_department

    attr_accessor :use_job_projects

    attr_accessor :allow_form_num_change

    attr_accessor :proof_changes_required_production_parts_status

    attr_accessor :ship_components_condition

    attr_accessor :ship_components

    attr_accessor :ship_part_condition

    attr_accessor :job2

    attr_accessor :allow_parts_on_multiple_combo_jobs

    attr_accessor :enable_ups_freightlink

    attr_accessor :job1

    attr_accessor :job4

    attr_accessor :unlock_production_status

    attr_accessor :job3

    attr_accessor :job6

    attr_accessor :job5

    attr_accessor :job8

    attr_accessor :job7

    attr_accessor :duplicate_estimate

    attr_accessor :job9

    attr_accessor :combo_job_percentage_calculation_type

    attr_accessor :allow_sales_tax_entry_on_change_orders

    attr_accessor :combo_job_percentage_calculation_xpath

    attr_accessor :ship_materials_condition

    attr_accessor :production_type

    attr_accessor :auto_create_estimate

    attr_accessor :ship_press_forms

    attr_accessor :attach_content_file_to_proof

    attr_accessor :proof_rejected_status

    attr_accessor :update_job_objects

    attr_accessor :ship_job_part_items

    attr_accessor :ship_materials

    attr_accessor :proof_approved_production_parts_status

    attr_accessor :ship_proofs

    attr_accessor :sync_part_from_materials

    attr_accessor :proof_rejected_production_parts_status

    attr_accessor :job_prefix1

    attr_accessor :job_prefix2

    attr_accessor :ship_part

    attr_accessor :auto_export_to_metrix_after_convert_to_job

    attr_accessor :job_prefix5

    attr_accessor :job_prefix6

    attr_accessor :job_prefix3

    attr_accessor :job_prefix4

    attr_accessor :metrix_timeout

    attr_accessor :job_prefix9

    attr_accessor :split_forms

    attr_accessor :job_prefix7

    attr_accessor :job_prefix8

    attr_accessor :max_proof_attachment_file_size

    attr_accessor :ship_press_forms_condition

    attr_accessor :ship_products_condition

    attr_accessor :proof_changes_required_status

    attr_accessor :legacy_shipments

    attr_accessor :exclude_from_status_update

    attr_accessor :ship_proofs_condition


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'network_location' => :'networkLocation',
        :'integrate_with_scheduling' => :'integrateWithScheduling',
        :'ship_job' => :'shipJob',
        :'ship_job_part_items_condition' => :'shipJobPartItemsCondition',
        :'combo_job_percentage_calculation_rounding_method' => :'comboJobPercentageCalculationRoundingMethod',
        :'job_shipment_date_time_mapping' => :'jobShipmentDateTimeMapping',
        :'ship_job_condition' => :'shipJobCondition',
        :'ship_products' => :'shipProducts',
        :'proof_approved_status' => :'proofApprovedStatus',
        :'default_freight_on_board' => :'defaultFreightOnBoard',
        :'proof_note_department' => :'proofNoteDepartment',
        :'use_job_projects' => :'useJobProjects',
        :'allow_form_num_change' => :'allowFormNumChange',
        :'proof_changes_required_production_parts_status' => :'proofChangesRequiredProductionPartsStatus',
        :'ship_components_condition' => :'shipComponentsCondition',
        :'ship_components' => :'shipComponents',
        :'ship_part_condition' => :'shipPartCondition',
        :'job2' => :'job2',
        :'allow_parts_on_multiple_combo_jobs' => :'allowPartsOnMultipleComboJobs',
        :'enable_ups_freightlink' => :'enableUPSFreightlink',
        :'job1' => :'job1',
        :'job4' => :'job4',
        :'unlock_production_status' => :'unlockProductionStatus',
        :'job3' => :'job3',
        :'job6' => :'job6',
        :'job5' => :'job5',
        :'job8' => :'job8',
        :'job7' => :'job7',
        :'duplicate_estimate' => :'duplicateEstimate',
        :'job9' => :'job9',
        :'combo_job_percentage_calculation_type' => :'comboJobPercentageCalculationType',
        :'allow_sales_tax_entry_on_change_orders' => :'allowSalesTaxEntryOnChangeOrders',
        :'combo_job_percentage_calculation_xpath' => :'comboJobPercentageCalculationXpath',
        :'ship_materials_condition' => :'shipMaterialsCondition',
        :'production_type' => :'productionType',
        :'auto_create_estimate' => :'autoCreateEstimate',
        :'ship_press_forms' => :'shipPressForms',
        :'attach_content_file_to_proof' => :'attachContentFileToProof',
        :'proof_rejected_status' => :'proofRejectedStatus',
        :'update_job_objects' => :'updateJobObjects',
        :'ship_job_part_items' => :'shipJobPartItems',
        :'ship_materials' => :'shipMaterials',
        :'proof_approved_production_parts_status' => :'proofApprovedProductionPartsStatus',
        :'ship_proofs' => :'shipProofs',
        :'sync_part_from_materials' => :'syncPartFromMaterials',
        :'proof_rejected_production_parts_status' => :'proofRejectedProductionPartsStatus',
        :'job_prefix1' => :'jobPrefix1',
        :'job_prefix2' => :'jobPrefix2',
        :'ship_part' => :'shipPart',
        :'auto_export_to_metrix_after_convert_to_job' => :'autoExportToMetrixAfterConvertToJob',
        :'job_prefix5' => :'jobPrefix5',
        :'job_prefix6' => :'jobPrefix6',
        :'job_prefix3' => :'jobPrefix3',
        :'job_prefix4' => :'jobPrefix4',
        :'metrix_timeout' => :'metrixTimeout',
        :'job_prefix9' => :'jobPrefix9',
        :'split_forms' => :'splitForms',
        :'job_prefix7' => :'jobPrefix7',
        :'job_prefix8' => :'jobPrefix8',
        :'max_proof_attachment_file_size' => :'maxProofAttachmentFileSize',
        :'ship_press_forms_condition' => :'shipPressFormsCondition',
        :'ship_products_condition' => :'shipProductsCondition',
        :'proof_changes_required_status' => :'proofChangesRequiredStatus',
        :'legacy_shipments' => :'legacyShipments',
        :'exclude_from_status_update' => :'excludeFromStatusUpdate',
        :'ship_proofs_condition' => :'shipProofsCondition'
      }
    end
  end
end
