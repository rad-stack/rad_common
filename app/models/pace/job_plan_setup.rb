module Pace
  class JobPlanSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :maximum_increment_attempts

    attr_accessor :task_list_auto_refresh

    attr_accessor :edi_log_level

    attr_accessor :allow_job_plan_refresh

    attr_accessor :default_manufacturing_location

    attr_accessor :minutes_past_start_for_late_performance

    attr_accessor :exclude_date_in_planning_records

    attr_accessor :plan_jobs_automatically

    attr_accessor :number_of_days

    attr_accessor :job_planning_plant_view_display_options

    attr_accessor :automatic_job_plan_update_from_job_type

    attr_accessor :update_job_plans

    attr_accessor :schedule_empty_jobs

    attr_accessor :default_proof_approval_activity_code

    attr_accessor :scheduled_activity_code

    attr_accessor :ganged_data_collection_bulk_entry

    attr_accessor :include_inactive_plans_in_pert_chart

    attr_accessor :default_combo_routing_template

    attr_accessor :use_advanced_job_planning


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'maximum_increment_attempts' => :'maximumIncrementAttempts',
        :'task_list_auto_refresh' => :'taskListAutoRefresh',
        :'edi_log_level' => :'ediLogLevel',
        :'allow_job_plan_refresh' => :'allowJobPlanRefresh',
        :'default_manufacturing_location' => :'defaultManufacturingLocation',
        :'minutes_past_start_for_late_performance' => :'minutesPastStartForLatePerformance',
        :'exclude_date_in_planning_records' => :'excludeDateInPlanningRecords',
        :'plan_jobs_automatically' => :'planJobsAutomatically',
        :'number_of_days' => :'numberOfDays',
        :'job_planning_plant_view_display_options' => :'jobPlanningPlantViewDisplayOptions',
        :'automatic_job_plan_update_from_job_type' => :'automaticJobPlanUpdateFromJobType',
        :'update_job_plans' => :'updateJobPlans',
        :'schedule_empty_jobs' => :'scheduleEmptyJobs',
        :'default_proof_approval_activity_code' => :'defaultProofApprovalActivityCode',
        :'scheduled_activity_code' => :'scheduledActivityCode',
        :'ganged_data_collection_bulk_entry' => :'gangedDataCollectionBulkEntry',
        :'include_inactive_plans_in_pert_chart' => :'includeInactivePlansInPertChart',
        :'default_combo_routing_template' => :'defaultComboRoutingTemplate',
        :'use_advanced_job_planning' => :'useAdvancedJobPlanning'
      }
    end
  end
end
