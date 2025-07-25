module Pace
  class Employee < Base
    attr_accessor :location

    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :password

    attr_accessor :status

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :plant_manager_id

    attr_accessor :state_key

    attr_accessor :phone_number

    attr_accessor :salutation

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :stop_time

    attr_accessor :no_logout_email_sent

    attr_accessor :paid_lunch

    attr_accessor :shift

    attr_accessor :vac_hrs_accrued

    attr_accessor :gl_override_account_id

    attr_accessor :require_password_for_transactions

    attr_accessor :lunch_start

    attr_accessor :allow_concurrent_entries

    attr_accessor :task_list_meta_data

    attr_accessor :activity_status

    attr_accessor :ask_pay_rate

    attr_accessor :job_list_type

    attr_accessor :ask_non_planned_reason

    attr_accessor :pay_rate07

    attr_accessor :pull_multiple_materials

    attr_accessor :pay_rate06

    attr_accessor :pay_rate05

    attr_accessor :pay_rate04

    attr_accessor :pay_rate03

    attr_accessor :pay_rate02

    attr_accessor :pay_rate01

    attr_accessor :printer

    attr_accessor :quick_entry

    attr_accessor :edit_own_entries_via_keypad

    attr_accessor :default_rate

    attr_accessor :pay_rate09

    attr_accessor :pay_rate08

    attr_accessor :last_name

    attr_accessor :pay_pds_per_yr

    attr_accessor :ask_job_plan_id

    attr_accessor :allow_entry_cloning

    attr_accessor :default_shift

    attr_accessor :union_code

    attr_accessor :secure_id

    attr_accessor :auto_pay_pd

    attr_accessor :normal_hrs_per_day

    attr_accessor :statutory_employee

    attr_accessor :is_supervisor

    attr_accessor :start_date_time

    attr_accessor :ask_job_material_id

    attr_accessor :federal_tax_tbl

    attr_accessor :current_non_charge

    attr_accessor :local_tax_tbl

    attr_accessor :require_password_for_action_screen

    attr_accessor :require_password_for_login

    attr_accessor :phone2

    attr_accessor :state_exempt

    attr_accessor :external_id

    attr_accessor :phone3

    attr_accessor :termination_date

    attr_accessor :use_materials

    attr_accessor :allow_pausing

    attr_accessor :ask_shift

    attr_accessor :bank_account

    attr_accessor :allow_reports

    attr_accessor :emergency_contact

    attr_accessor :display_employee_time

    attr_accessor :complete_runs

    attr_accessor :first_name

    attr_accessor :state_tax_tbl

    attr_accessor :allow_overlapping

    attr_accessor :salary_rate

    attr_accessor :last_increase_date

    attr_accessor :social_security_num

    attr_accessor :allow_queries

    attr_accessor :access_previous_shift

    attr_accessor :display_materials

    attr_accessor :lunch_stop

    attr_accessor :display_job_planning

    attr_accessor :federal_exempt

    attr_accessor :review_date

    attr_accessor :allow_ganging

    attr_accessor :department

    attr_accessor :display_closed_jobs

    attr_accessor :national_insurance_num

    attr_accessor :sick_hrs_accrued

    attr_accessor :weeks_worked_qtd

    attr_accessor :base_hrs_per_pd

    attr_accessor :local_exempt

    attr_accessor :birth_date

    attr_accessor :display_non_chargeable_time

    attr_accessor :ask_job_component

    attr_accessor :signed_in

    attr_accessor :emergency_phone


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'location' => :'location',
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'password' => :'password',
        :'status' => :'status',
        :'email' => :'email',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'plant_manager_id' => :'plantManagerId',
        :'state_key' => :'stateKey',
        :'phone_number' => :'phoneNumber',
        :'salutation' => :'salutation',
        :'zip' => :'zip',
        :'city' => :'city',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'stop_time' => :'stopTime',
        :'no_logout_email_sent' => :'noLogoutEmailSent',
        :'paid_lunch' => :'paidLunch',
        :'shift' => :'shift',
        :'vac_hrs_accrued' => :'vacHrsAccrued',
        :'gl_override_account_id' => :'glOverrideAccountID',
        :'require_password_for_transactions' => :'requirePasswordForTransactions',
        :'lunch_start' => :'lunchStart',
        :'allow_concurrent_entries' => :'allowConcurrentEntries',
        :'task_list_meta_data' => :'taskListMetaData',
        :'activity_status' => :'activityStatus',
        :'ask_pay_rate' => :'askPayRate',
        :'job_list_type' => :'jobListType',
        :'ask_non_planned_reason' => :'askNonPlannedReason',
        :'pay_rate07' => :'payRate07',
        :'pull_multiple_materials' => :'pullMultipleMaterials',
        :'pay_rate06' => :'payRate06',
        :'pay_rate05' => :'payRate05',
        :'pay_rate04' => :'payRate04',
        :'pay_rate03' => :'payRate03',
        :'pay_rate02' => :'payRate02',
        :'pay_rate01' => :'payRate01',
        :'printer' => :'printer',
        :'quick_entry' => :'quickEntry',
        :'edit_own_entries_via_keypad' => :'editOwnEntriesViaKeypad',
        :'default_rate' => :'defaultRate',
        :'pay_rate09' => :'payRate09',
        :'pay_rate08' => :'payRate08',
        :'last_name' => :'lastName',
        :'pay_pds_per_yr' => :'payPdsPerYr',
        :'ask_job_plan_id' => :'askJobPlanID',
        :'allow_entry_cloning' => :'allowEntryCloning',
        :'default_shift' => :'defaultShift',
        :'union_code' => :'unionCode',
        :'secure_id' => :'secureId',
        :'auto_pay_pd' => :'autoPayPd',
        :'normal_hrs_per_day' => :'normalHrsPerDay',
        :'statutory_employee' => :'statutoryEmployee',
        :'is_supervisor' => :'isSupervisor',
        :'start_date_time' => :'startDateTime',
        :'ask_job_material_id' => :'askJobMaterialID',
        :'federal_tax_tbl' => :'federalTaxTbl',
        :'current_non_charge' => :'currentNonCharge',
        :'local_tax_tbl' => :'localTaxTbl',
        :'require_password_for_action_screen' => :'requirePasswordForActionScreen',
        :'require_password_for_login' => :'requirePasswordForLogin',
        :'phone2' => :'phone2',
        :'state_exempt' => :'stateExempt',
        :'external_id' => :'externalID',
        :'phone3' => :'phone3',
        :'termination_date' => :'terminationDate',
        :'use_materials' => :'useMaterials',
        :'allow_pausing' => :'allowPausing',
        :'ask_shift' => :'askShift',
        :'bank_account' => :'bankAccount',
        :'allow_reports' => :'allowReports',
        :'emergency_contact' => :'emergencyContact',
        :'display_employee_time' => :'displayEmployeeTime',
        :'complete_runs' => :'completeRuns',
        :'first_name' => :'firstName',
        :'state_tax_tbl' => :'stateTaxTbl',
        :'allow_overlapping' => :'allowOverlapping',
        :'salary_rate' => :'salaryRate',
        :'last_increase_date' => :'lastIncreaseDate',
        :'social_security_num' => :'socialSecurityNum',
        :'allow_queries' => :'allowQueries',
        :'access_previous_shift' => :'accessPreviousShift',
        :'display_materials' => :'displayMaterials',
        :'lunch_stop' => :'lunchStop',
        :'display_job_planning' => :'displayJobPlanning',
        :'federal_exempt' => :'federalExempt',
        :'review_date' => :'reviewDate',
        :'allow_ganging' => :'allowGanging',
        :'department' => :'department',
        :'display_closed_jobs' => :'displayClosedJobs',
        :'national_insurance_num' => :'nationalInsuranceNum',
        :'sick_hrs_accrued' => :'sickHrsAccrued',
        :'weeks_worked_qtd' => :'weeksWorkedQTD',
        :'base_hrs_per_pd' => :'baseHrsPerPd',
        :'local_exempt' => :'localExempt',
        :'birth_date' => :'birthDate',
        :'display_non_chargeable_time' => :'displayNonChargeableTime',
        :'ask_job_component' => :'askJobComponent',
        :'signed_in' => :'signedIn',
        :'emergency_phone' => :'emergencyPhone'
      }
    end
  end
end
