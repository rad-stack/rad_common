module Pace
  class Department < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

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

    attr_accessor :note_category

    attr_accessor :operator_viewable

    attr_accessor :beginning_time_of_day

    attr_accessor :employee_time_early_buffer

    attr_accessor :department_manager

    attr_accessor :beginning_day_of_week

    attr_accessor :employee_time_rounding

    attr_accessor :sign_out_report

    attr_accessor :employee_time_late_buffer

    attr_accessor :available_in_shipping_app


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
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
        :'note_category' => :'noteCategory',
        :'operator_viewable' => :'operatorViewable',
        :'beginning_time_of_day' => :'beginningTimeOfDay',
        :'employee_time_early_buffer' => :'employeeTimeEarlyBuffer',
        :'department_manager' => :'departmentManager',
        :'beginning_day_of_week' => :'beginningDayOfWeek',
        :'employee_time_rounding' => :'employeeTimeRounding',
        :'sign_out_report' => :'signOutReport',
        :'employee_time_late_buffer' => :'employeeTimeLateBuffer',
        :'available_in_shipping_app' => :'availableInShippingApp'
      }
    end
  end
end
