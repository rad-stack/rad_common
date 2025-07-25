module Pace
  class EstimateConvertToJob < Base
    attr_accessor :estimate

    attr_accessor :estimate_convert_to_job_parts

    attr_accessor :description

    attr_accessor :contact

    attr_accessor :notes

    attr_accessor :allowable_overs

    attr_accessor :customer

    attr_accessor :po_number

    attr_accessor :quantity_ordered

    attr_accessor :job_type

    attr_accessor :sub_job_type

    attr_accessor :invoice_level_options

    attr_accessor :last_job

    attr_accessor :job_project

    attr_accessor :job_status

    attr_accessor :job_order_type

    attr_accessor :overs_method

    attr_accessor :convert_into_job

    attr_accessor :create_new_job

    attr_accessor :update_job_info

    attr_accessor :remove_extra_job_parts

    attr_accessor :charge_back_number

    attr_accessor :override_addl_per_m

    attr_accessor :override_price

    attr_accessor :single_product

    attr_accessor :promise_date_time

    attr_accessor :scheduled_ship_date_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'estimate' => :'estimate',
        :'estimate_convert_to_job_parts' => :'estimateConvertToJobParts',
        :'description' => :'description',
        :'contact' => :'contact',
        :'notes' => :'notes',
        :'allowable_overs' => :'allowableOvers',
        :'customer' => :'customer',
        :'po_number' => :'poNumber',
        :'quantity_ordered' => :'quantityOrdered',
        :'job_type' => :'jobType',
        :'sub_job_type' => :'subJobType',
        :'invoice_level_options' => :'invoiceLevelOptions',
        :'last_job' => :'lastJob',
        :'job_project' => :'jobProject',
        :'job_status' => :'jobStatus',
        :'job_order_type' => :'jobOrderType',
        :'overs_method' => :'oversMethod',
        :'convert_into_job' => :'convertIntoJob',
        :'create_new_job' => :'createNewJob',
        :'update_job_info' => :'updateJobInfo',
        :'remove_extra_job_parts' => :'removeExtraJobParts',
        :'charge_back_number' => :'chargeBackNumber',
        :'override_addl_per_m' => :'overrideAddlPerM',
        :'override_price' => :'overridePrice',
        :'single_product' => :'singleProduct',
        :'promise_date_time' => :'promiseDateTime',
        :'scheduled_ship_date_time' => :'scheduledShipDateTime'
      }
    end
  end
end
