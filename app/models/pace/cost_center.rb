module Pace
  class CostCenter < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :plant_manager_id

    attr_accessor :manufacturing_location

    attr_accessor :pace_connect

    attr_accessor :department

    attr_accessor :inventory_bin

    attr_accessor :inventory_location

    attr_accessor :jdf_device_id

    attr_accessor :linked_cost_center

    attr_accessor :sent_to_print_flow

    attr_accessor :cost_center_type

    attr_accessor :jdf_submit_method

    attr_accessor :location_bin_key

    attr_accessor :web_cam

    attr_accessor :budgeted_annual_hours

    attr_accessor :hours_available

    attr_accessor :jdf_quantity_from_job_plan

    attr_accessor :budgeted_hourly_rate

    attr_accessor :budgeted_hours

    attr_accessor :jdf_submit_time_buffer

    attr_accessor :earliest_start_time_push_minutes

    attr_accessor :enable_plant_manager

    attr_accessor :print_flow_class

    attr_accessor :total_impressions

    attr_accessor :allow_auto_count_login


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'plant_manager_id' => :'plantManagerId',
        :'manufacturing_location' => :'manufacturingLocation',
        :'pace_connect' => :'paceConnect',
        :'department' => :'department',
        :'inventory_bin' => :'inventoryBin',
        :'inventory_location' => :'inventoryLocation',
        :'jdf_device_id' => :'jdfDeviceID',
        :'linked_cost_center' => :'linkedCostCenter',
        :'sent_to_print_flow' => :'sentToPrintFlow',
        :'cost_center_type' => :'costCenterType',
        :'jdf_submit_method' => :'jdfSubmitMethod',
        :'location_bin_key' => :'locationBinKey',
        :'web_cam' => :'webCam',
        :'budgeted_annual_hours' => :'budgetedAnnualHours',
        :'hours_available' => :'hoursAvailable',
        :'jdf_quantity_from_job_plan' => :'jdfQuantityFromJobPlan',
        :'budgeted_hourly_rate' => :'budgetedHourlyRate',
        :'budgeted_hours' => :'budgetedHours',
        :'jdf_submit_time_buffer' => :'jdfSubmitTimeBuffer',
        :'earliest_start_time_push_minutes' => :'earliestStartTimePushMinutes',
        :'enable_plant_manager' => :'enablePlantManager',
        :'print_flow_class' => :'printFlowClass',
        :'total_impressions' => :'totalImpressions',
        :'allow_auto_count_login' => :'allowAutoCountLogin'
      }
    end
  end
end
