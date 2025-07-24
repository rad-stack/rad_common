module Pace
  class DataCollectionSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :allow_concurrent_entries

    attr_accessor :ask_pay_rate

    attr_accessor :job_list_type

    attr_accessor :ask_non_planned_reason

    attr_accessor :pull_multiple_materials

    attr_accessor :quick_entry

    attr_accessor :ask_job_plan_id

    attr_accessor :allow_entry_cloning

    attr_accessor :ask_job_material_id

    attr_accessor :use_materials

    attr_accessor :allow_pausing

    attr_accessor :ask_shift

    attr_accessor :allow_reports

    attr_accessor :display_employee_time

    attr_accessor :complete_runs

    attr_accessor :allow_overlapping

    attr_accessor :allow_queries

    attr_accessor :access_previous_shift

    attr_accessor :display_materials

    attr_accessor :display_job_planning

    attr_accessor :allow_ganging

    attr_accessor :display_closed_jobs

    attr_accessor :display_non_chargeable_time

    attr_accessor :ask_job_component

    attr_accessor :task_list_without_scheduling

    attr_accessor :dcconfiguration_level

    attr_accessor :show_current_activities


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'allow_concurrent_entries' => :'allowConcurrentEntries',
        :'ask_pay_rate' => :'askPayRate',
        :'job_list_type' => :'jobListType',
        :'ask_non_planned_reason' => :'askNonPlannedReason',
        :'pull_multiple_materials' => :'pullMultipleMaterials',
        :'quick_entry' => :'quickEntry',
        :'ask_job_plan_id' => :'askJobPlanID',
        :'allow_entry_cloning' => :'allowEntryCloning',
        :'ask_job_material_id' => :'askJobMaterialID',
        :'use_materials' => :'useMaterials',
        :'allow_pausing' => :'allowPausing',
        :'ask_shift' => :'askShift',
        :'allow_reports' => :'allowReports',
        :'display_employee_time' => :'displayEmployeeTime',
        :'complete_runs' => :'completeRuns',
        :'allow_overlapping' => :'allowOverlapping',
        :'allow_queries' => :'allowQueries',
        :'access_previous_shift' => :'accessPreviousShift',
        :'display_materials' => :'displayMaterials',
        :'display_job_planning' => :'displayJobPlanning',
        :'allow_ganging' => :'allowGanging',
        :'display_closed_jobs' => :'displayClosedJobs',
        :'display_non_chargeable_time' => :'displayNonChargeableTime',
        :'ask_job_component' => :'askJobComponent',
        :'task_list_without_scheduling' => :'taskListWithoutScheduling',
        :'dcconfiguration_level' => :'dcconfigurationLevel',
        :'show_current_activities' => :'showCurrentActivities'
      }
    end
  end
end
