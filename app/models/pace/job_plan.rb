module Pace
  class JobPlan < Base
    attr_accessor :priority

    attr_accessor :id

    attr_accessor :active

    attr_accessor :predecessor

    attr_accessor :component

    attr_accessor :status

    attr_accessor :editable

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part_press_form

    attr_accessor :proof

    attr_accessor :job

    attr_accessor :plant_manager_id

    attr_accessor :manufacturing_location

    attr_accessor :manual

    attr_accessor :note

    attr_accessor :lead_time

    attr_accessor :setup_hours

    attr_accessor :start_date_time

    attr_accessor :activity_code

    attr_accessor :end_date_time

    attr_accessor :assigned_to

    attr_accessor :actual_hours

    attr_accessor :purchase_order_line

    attr_accessor :quote_source

    attr_accessor :estimated_hours

    attr_accessor :job_shipment

    attr_accessor :run_hours

    attr_accessor :run

    attr_accessor :scheduled_flag

    attr_accessor :plant_manager_material_consumed

    attr_accessor :earliest_start_date_time

    attr_accessor :jdf_submit_time_buffer

    attr_accessor :part

    attr_accessor :plant_manager_run_status

    attr_accessor :next_job_plan_ids

    attr_accessor :lag_time

    attr_accessor :on_schedule_board

    attr_accessor :activity_code_forced

    attr_accessor :print_flow_last_run_code

    attr_accessor :quantity_to_produce

    attr_accessor :internal_split_source

    attr_accessor :rerun_quantity

    attr_accessor :device_complete

    attr_accessor :group_sequence

    attr_accessor :scheduled_hours

    attr_accessor :link_status

    attr_accessor :number_of_splits

    attr_accessor :submitted_to_device

    attr_accessor :earliest_date_time_increment_counter

    attr_accessor :percent_completed

    attr_accessor :print_flow_form

    attr_accessor :remaining_hours

    attr_accessor :device_error

    attr_accessor :switchover_hours

    attr_accessor :scheduled_activity

    attr_accessor :finishing

    attr_accessor :estimated_production_units

    attr_accessor :plant_manager_synchronized

    attr_accessor :actual_end_date_time

    attr_accessor :plant_manager_last_message

    attr_accessor :split_factor

    attr_accessor :from_job_type

    attr_accessor :device_submission_id

    attr_accessor :actual_start_date_time

    attr_accessor :has_been_submitted_to_device

    attr_accessor :previous_job_plan_ids

    attr_accessor :print_flow_id

    attr_accessor :previous_task

    attr_accessor :task_locked

    attr_accessor :next_task

    attr_accessor :planned_hours


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'priority' => :'priority',
        :'id' => :'id',
        :'active' => :'active',
        :'predecessor' => :'predecessor',
        :'component' => :'component',
        :'status' => :'status',
        :'editable' => :'editable',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part_press_form' => :'jobPartPressForm',
        :'proof' => :'proof',
        :'job' => :'job',
        :'plant_manager_id' => :'plantManagerId',
        :'manufacturing_location' => :'manufacturingLocation',
        :'manual' => :'manual',
        :'note' => :'note',
        :'lead_time' => :'leadTime',
        :'setup_hours' => :'setupHours',
        :'start_date_time' => :'startDateTime',
        :'activity_code' => :'activityCode',
        :'end_date_time' => :'endDateTime',
        :'assigned_to' => :'assignedTo',
        :'actual_hours' => :'actualHours',
        :'purchase_order_line' => :'purchaseOrderLine',
        :'quote_source' => :'quoteSource',
        :'estimated_hours' => :'estimatedHours',
        :'job_shipment' => :'jobShipment',
        :'run_hours' => :'runHours',
        :'run' => :'run',
        :'scheduled_flag' => :'scheduledFlag',
        :'plant_manager_material_consumed' => :'plantManagerMaterialConsumed',
        :'earliest_start_date_time' => :'earliestStartDateTime',
        :'jdf_submit_time_buffer' => :'jdfSubmitTimeBuffer',
        :'part' => :'part',
        :'plant_manager_run_status' => :'plantManagerRunStatus',
        :'next_job_plan_ids' => :'nextJobPlanIDs',
        :'lag_time' => :'lagTime',
        :'on_schedule_board' => :'onScheduleBoard',
        :'activity_code_forced' => :'activityCodeForced',
        :'print_flow_last_run_code' => :'printFlowLastRunCode',
        :'quantity_to_produce' => :'quantityToProduce',
        :'internal_split_source' => :'internalSplitSource',
        :'rerun_quantity' => :'rerunQuantity',
        :'device_complete' => :'deviceComplete',
        :'group_sequence' => :'groupSequence',
        :'scheduled_hours' => :'scheduledHours',
        :'link_status' => :'linkStatus',
        :'number_of_splits' => :'numberOfSplits',
        :'submitted_to_device' => :'submittedToDevice',
        :'earliest_date_time_increment_counter' => :'earliestDateTimeIncrementCounter',
        :'percent_completed' => :'percentCompleted',
        :'print_flow_form' => :'printFlowForm',
        :'remaining_hours' => :'remainingHours',
        :'device_error' => :'deviceError',
        :'switchover_hours' => :'switchoverHours',
        :'scheduled_activity' => :'scheduledActivity',
        :'finishing' => :'finishing',
        :'estimated_production_units' => :'estimatedProductionUnits',
        :'plant_manager_synchronized' => :'plantManagerSynchronized',
        :'actual_end_date_time' => :'actualEndDateTime',
        :'plant_manager_last_message' => :'plantManagerLastMessage',
        :'split_factor' => :'splitFactor',
        :'from_job_type' => :'fromJobType',
        :'device_submission_id' => :'deviceSubmissionId',
        :'actual_start_date_time' => :'actualStartDateTime',
        :'has_been_submitted_to_device' => :'hasBeenSubmittedToDevice',
        :'previous_job_plan_ids' => :'previousJobPlanIDs',
        :'print_flow_id' => :'printFlowId',
        :'previous_task' => :'previousTask',
        :'task_locked' => :'taskLocked',
        :'next_task' => :'nextTask',
        :'planned_hours' => :'plannedHours'
      }
    end
  end
end
