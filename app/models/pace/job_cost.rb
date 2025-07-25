module Pace
  class JobCost < Base
    attr_accessor :id

    attr_accessor :hours

    attr_accessor :component

    attr_accessor :closed

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :plant_manager_id

    attr_accessor :source_type

    attr_accessor :bill_rate

    attr_accessor :employee_time

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :employee

    attr_accessor :approved

    attr_accessor :transaction_type

    attr_accessor :inventory_item

    attr_accessor :estimate_part

    attr_accessor :posting_status

    attr_accessor :vendor

    attr_accessor :correlation_id

    attr_accessor :shift

    attr_accessor :quick_entry

    attr_accessor :start_date_time

    attr_accessor :cost

    attr_accessor :non_planned_reason

    attr_accessor :activity_code

    attr_accessor :estimate

    attr_accessor :purchase_order_receipt

    attr_accessor :end_date_time

    attr_accessor :invoice_extra

    attr_accessor :invoice

    attr_accessor :ganged_estimated_hours

    attr_accessor :negated

    attr_accessor :actual_inventory_qty

    attr_accessor :in_wip

    attr_accessor :total_estimated_hours

    attr_accessor :date_expensed

    attr_accessor :estimated_prod_units

    attr_accessor :actual_hours

    attr_accessor :print_flow_split_number

    attr_accessor :estimated_inventory_qty

    attr_accessor :count_difference

    attr_accessor :payroll_cost

    attr_accessor :begin_meter

    attr_accessor :estimated_sell

    attr_accessor :estimated_cost

    attr_accessor :purchase_order_line

    attr_accessor :pause

    attr_accessor :billing_premium

    attr_accessor :overlap

    attr_accessor :quote_source

    attr_accessor :end_count

    attr_accessor :estimated_hours

    attr_accessor :end_meter

    attr_accessor :register_num

    attr_accessor :inventory_qty

    attr_accessor :inventory_cost

    attr_accessor :prod_units

    attr_accessor :close_activity

    attr_accessor :job_plan

    attr_accessor :auto_post

    attr_accessor :rate

    attr_accessor :include_in_additional_per_m

    attr_accessor :journal_code

    attr_accessor :failed_auto_post_reason

    attr_accessor :begin_count

    attr_accessor :jdf_source

    attr_accessor :override_job_status

    attr_accessor :postable

    attr_accessor :actual_cost

    attr_accessor :postage_used

    attr_accessor :edit_flag

    attr_accessor :inventory_line

    attr_accessor :source_id

    attr_accessor :failed_auto_post

    attr_accessor :paused_date_time

    attr_accessor :paused_hours

    attr_accessor :actual_prod_units

    attr_accessor :purchase_order

    attr_accessor :complete

    attr_accessor :charge_class


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'hours' => :'hours',
        :'component' => :'component',
        :'closed' => :'closed',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'plant_manager_id' => :'plantManagerId',
        :'source_type' => :'sourceType',
        :'bill_rate' => :'billRate',
        :'employee_time' => :'employeeTime',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'employee' => :'employee',
        :'approved' => :'approved',
        :'transaction_type' => :'transactionType',
        :'inventory_item' => :'inventoryItem',
        :'estimate_part' => :'estimatePart',
        :'posting_status' => :'postingStatus',
        :'vendor' => :'vendor',
        :'correlation_id' => :'correlationId',
        :'shift' => :'shift',
        :'quick_entry' => :'quickEntry',
        :'start_date_time' => :'startDateTime',
        :'cost' => :'cost',
        :'non_planned_reason' => :'nonPlannedReason',
        :'activity_code' => :'activityCode',
        :'estimate' => :'estimate',
        :'purchase_order_receipt' => :'purchaseOrderReceipt',
        :'end_date_time' => :'endDateTime',
        :'invoice_extra' => :'invoiceExtra',
        :'invoice' => :'invoice',
        :'ganged_estimated_hours' => :'gangedEstimatedHours',
        :'negated' => :'negated',
        :'actual_inventory_qty' => :'actualInventoryQty',
        :'in_wip' => :'inWIP',
        :'total_estimated_hours' => :'totalEstimatedHours',
        :'date_expensed' => :'dateExpensed',
        :'estimated_prod_units' => :'estimatedProdUnits',
        :'actual_hours' => :'actualHours',
        :'print_flow_split_number' => :'printFlowSplitNumber',
        :'estimated_inventory_qty' => :'estimatedInventoryQty',
        :'count_difference' => :'countDifference',
        :'payroll_cost' => :'payrollCost',
        :'begin_meter' => :'beginMeter',
        :'estimated_sell' => :'estimatedSell',
        :'estimated_cost' => :'estimatedCost',
        :'purchase_order_line' => :'purchaseOrderLine',
        :'pause' => :'pause',
        :'billing_premium' => :'billingPremium',
        :'overlap' => :'overlap',
        :'quote_source' => :'quoteSource',
        :'end_count' => :'endCount',
        :'estimated_hours' => :'estimatedHours',
        :'end_meter' => :'endMeter',
        :'register_num' => :'registerNum',
        :'inventory_qty' => :'inventoryQty',
        :'inventory_cost' => :'inventoryCost',
        :'prod_units' => :'prodUnits',
        :'close_activity' => :'closeActivity',
        :'job_plan' => :'jobPlan',
        :'auto_post' => :'autoPost',
        :'rate' => :'rate',
        :'include_in_additional_per_m' => :'includeInAdditionalPerM',
        :'journal_code' => :'journalCode',
        :'failed_auto_post_reason' => :'failedAutoPostReason',
        :'begin_count' => :'beginCount',
        :'jdf_source' => :'jdfSource',
        :'override_job_status' => :'overrideJobStatus',
        :'postable' => :'postable',
        :'actual_cost' => :'actualCost',
        :'postage_used' => :'postageUsed',
        :'edit_flag' => :'editFlag',
        :'inventory_line' => :'inventoryLine',
        :'source_id' => :'sourceID',
        :'failed_auto_post' => :'failedAutoPost',
        :'paused_date_time' => :'pausedDateTime',
        :'paused_hours' => :'pausedHours',
        :'actual_prod_units' => :'actualProdUnits',
        :'purchase_order' => :'purchaseOrder',
        :'complete' => :'complete',
        :'charge_class' => :'chargeClass'
      }
    end
  end
end
