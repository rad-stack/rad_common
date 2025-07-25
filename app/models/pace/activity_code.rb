module Pace
  class ActivityCode < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :predecessor

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :plant_manager_id

    attr_accessor :cost_center

    attr_accessor :lead_time

    attr_accessor :inventory_item

    attr_accessor :ask_non_planned_reason

    attr_accessor :uom

    attr_accessor :combo_job_percentage_calculation_rounding_method

    attr_accessor :combo_job_percentage_calculation_type

    attr_accessor :combo_job_percentage_calculation_xpath

    attr_accessor :paper

    attr_accessor :ask_if_complete

    attr_accessor :invoice_extra_type

    attr_accessor :material_activity_code

    attr_accessor :plant_manager_report_category

    attr_accessor :plant_manager_dmi_category

    attr_accessor :lag_time

    attr_accessor :link_status

    attr_accessor :estimate_activity_code

    attr_accessor :update_planning

    attr_accessor :cost_markup_category

    attr_accessor :on_critical_date_dashboard

    attr_accessor :max_quantity

    attr_accessor :postage_activity_code

    attr_accessor :wip_debit

    attr_accessor :production_units_des

    attr_accessor :include_non_inventory_items

    attr_accessor :ask_notes_by_line

    attr_accessor :planning_time_calculation_percent

    attr_accessor :ask_quantity_of_materials

    attr_accessor :cogs_credit

    attr_accessor :cogs_debit

    attr_accessor :use_combo_split

    attr_accessor :machine_cost_category

    attr_accessor :include_as_cost

    attr_accessor :pre_press_act

    attr_accessor :job_plan_level

    attr_accessor :ask_notes

    attr_accessor :ask_prod_unit_by_line

    attr_accessor :exclude_prod_units_in_rollup

    attr_accessor :include_in_value_added

    attr_accessor :matl_amt_per_unit

    attr_accessor :matl_qty_per_unit

    attr_accessor :ask_inventory

    attr_accessor :ask_prod_unit

    attr_accessor :jdf_default_phase

    attr_accessor :map_planned_activities

    attr_accessor :outside_purchase

    attr_accessor :charge_basis

    attr_accessor :rollup_activity

    attr_accessor :ask_postage

    attr_accessor :default_complete_value

    attr_accessor :create_actual_costs

    attr_accessor :consolidate_extras

    attr_accessor :plan_by_pass

    attr_accessor :wip_category

    attr_accessor :estimate_result_type

    attr_accessor :ganged_job_cost_distribution_method

    attr_accessor :update_job_part_location

    attr_accessor :matl_prompt

    attr_accessor :planning_integration

    attr_accessor :labor_cost_category

    attr_accessor :material_other_category

    attr_accessor :change_job_status_to

    attr_accessor :wip_credit

    attr_accessor :general_oa_category

    attr_accessor :stand_prod_units_per_h

    attr_accessor :markup_category

    attr_accessor :add_job_tracking

    attr_accessor :normal_pay_rate

    attr_accessor :revenue_producing

    attr_accessor :labor_overhead_category

    attr_accessor :ask_counts

    attr_accessor :hrs_per_prod_unit

    attr_accessor :ganged_dc_activity_material_pull_consolidation

    attr_accessor :update_cur_dept

    attr_accessor :time_until_late

    attr_accessor :inventory_prompt

    attr_accessor :show_job_plan_on_task_list

    attr_accessor :standard_charge

    attr_accessor :multiple_upstream_tasks

    attr_accessor :show_materials_on_task_list

    attr_accessor :map_planned_activity

    attr_accessor :planning_time_calculation


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'predecessor' => :'predecessor',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'plant_manager_id' => :'plantManagerId',
        :'cost_center' => :'costCenter',
        :'lead_time' => :'leadTime',
        :'inventory_item' => :'inventoryItem',
        :'ask_non_planned_reason' => :'askNonPlannedReason',
        :'uom' => :'uom',
        :'combo_job_percentage_calculation_rounding_method' => :'comboJobPercentageCalculationRoundingMethod',
        :'combo_job_percentage_calculation_type' => :'comboJobPercentageCalculationType',
        :'combo_job_percentage_calculation_xpath' => :'comboJobPercentageCalculationXpath',
        :'paper' => :'paper',
        :'ask_if_complete' => :'askIfComplete',
        :'invoice_extra_type' => :'invoiceExtraType',
        :'material_activity_code' => :'materialActivityCode',
        :'plant_manager_report_category' => :'plantManagerReportCategory',
        :'plant_manager_dmi_category' => :'plantManagerDMICategory',
        :'lag_time' => :'lagTime',
        :'link_status' => :'linkStatus',
        :'estimate_activity_code' => :'estimateActivityCode',
        :'update_planning' => :'updatePlanning',
        :'cost_markup_category' => :'costMarkupCategory',
        :'on_critical_date_dashboard' => :'onCriticalDateDashboard',
        :'max_quantity' => :'maxQuantity',
        :'postage_activity_code' => :'postageActivityCode',
        :'wip_debit' => :'wipDebit',
        :'production_units_des' => :'productionUnitsDes',
        :'include_non_inventory_items' => :'includeNonInventoryItems',
        :'ask_notes_by_line' => :'askNotesByLine',
        :'planning_time_calculation_percent' => :'planningTimeCalculationPercent',
        :'ask_quantity_of_materials' => :'askQuantityOfMaterials',
        :'cogs_credit' => :'cogsCredit',
        :'cogs_debit' => :'cogsDebit',
        :'use_combo_split' => :'useComboSplit',
        :'machine_cost_category' => :'machineCostCategory',
        :'include_as_cost' => :'includeAsCost',
        :'pre_press_act' => :'prePressAct',
        :'job_plan_level' => :'jobPlanLevel',
        :'ask_notes' => :'askNotes',
        :'ask_prod_unit_by_line' => :'askProdUnitByLine',
        :'exclude_prod_units_in_rollup' => :'excludeProdUnitsInRollup',
        :'include_in_value_added' => :'includeInValueAdded',
        :'matl_amt_per_unit' => :'matlAmtPerUnit',
        :'matl_qty_per_unit' => :'matlQtyPerUnit',
        :'ask_inventory' => :'askInventory',
        :'ask_prod_unit' => :'askProdUnit',
        :'jdf_default_phase' => :'jdfDefaultPhase',
        :'map_planned_activities' => :'mapPlannedActivities',
        :'outside_purchase' => :'outsidePurchase',
        :'charge_basis' => :'chargeBasis',
        :'rollup_activity' => :'rollupActivity',
        :'ask_postage' => :'askPostage',
        :'default_complete_value' => :'defaultCompleteValue',
        :'create_actual_costs' => :'createActualCosts',
        :'consolidate_extras' => :'consolidateExtras',
        :'plan_by_pass' => :'planByPass',
        :'wip_category' => :'wipCategory',
        :'estimate_result_type' => :'estimateResultType',
        :'ganged_job_cost_distribution_method' => :'gangedJobCostDistributionMethod',
        :'update_job_part_location' => :'updateJobPartLocation',
        :'matl_prompt' => :'matlPrompt',
        :'planning_integration' => :'planningIntegration',
        :'labor_cost_category' => :'laborCostCategory',
        :'material_other_category' => :'materialOtherCategory',
        :'change_job_status_to' => :'changeJobStatusTo',
        :'wip_credit' => :'wipCredit',
        :'general_oa_category' => :'generalOACategory',
        :'stand_prod_units_per_h' => :'standProdUnitsPerH',
        :'markup_category' => :'markupCategory',
        :'add_job_tracking' => :'addJobTracking',
        :'normal_pay_rate' => :'normalPayRate',
        :'revenue_producing' => :'revenueProducing',
        :'labor_overhead_category' => :'laborOverheadCategory',
        :'ask_counts' => :'askCounts',
        :'hrs_per_prod_unit' => :'hrsPerProdUnit',
        :'ganged_dc_activity_material_pull_consolidation' => :'gangedDCActivityMaterialPullConsolidation',
        :'update_cur_dept' => :'updateCurDept',
        :'time_until_late' => :'timeUntilLate',
        :'inventory_prompt' => :'inventoryPrompt',
        :'show_job_plan_on_task_list' => :'showJobPlanOnTaskList',
        :'standard_charge' => :'standardCharge',
        :'multiple_upstream_tasks' => :'multipleUpstreamTasks',
        :'show_materials_on_task_list' => :'showMaterialsOnTaskList',
        :'map_planned_activity' => :'mapPlannedActivity',
        :'planning_time_calculation' => :'planningTimeCalculation'
      }
    end
  end
end
