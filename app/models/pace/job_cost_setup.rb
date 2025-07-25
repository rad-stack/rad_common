module Pace
  class JobCostSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :interface_gl

    attr_accessor :allow_process_all

    attr_accessor :ask_non_planned_reason

    attr_accessor :job_cost_post_to_payroll

    attr_accessor :auto_job_numbering

    attr_accessor :job_costs_are_sell

    attr_accessor :ask_premium_pay

    attr_accessor :ask_job_part_number_in_dc

    attr_accessor :delivery_ticket_name

    attr_accessor :ask_if_complete

    attr_accessor :ask_overlap

    attr_accessor :stock_pull_activity_code

    attr_accessor :use_direct_labor

    attr_accessor :offset_activity_code

    attr_accessor :change_order_bill_form_name

    attr_accessor :change_order_notice_name

    attr_accessor :ship_label_name

    attr_accessor :planning_form_name

    attr_accessor :stock_ticket_name

    attr_accessor :wip_entry_format

    attr_accessor :change_order_name

    attr_accessor :order_confirm_name

    attr_accessor :ship_ticket_name

    attr_accessor :show_change_order_amounts

    attr_accessor :relieve_partial_wip_per_part

    attr_accessor :use_variable_markup

    attr_accessor :check_planned_work

    attr_accessor :last_action_from_job_cost


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'interface_gl' => :'interfaceGL',
        :'allow_process_all' => :'allowProcessAll',
        :'ask_non_planned_reason' => :'askNonPlannedReason',
        :'job_cost_post_to_payroll' => :'jobCostPostToPayroll',
        :'auto_job_numbering' => :'autoJobNumbering',
        :'job_costs_are_sell' => :'jobCostsAreSell',
        :'ask_premium_pay' => :'askPremiumPay',
        :'ask_job_part_number_in_dc' => :'askJobPartNumberInDC',
        :'delivery_ticket_name' => :'deliveryTicketName',
        :'ask_if_complete' => :'askIfComplete',
        :'ask_overlap' => :'askOverlap',
        :'stock_pull_activity_code' => :'stockPullActivityCode',
        :'use_direct_labor' => :'useDirectLabor',
        :'offset_activity_code' => :'offsetActivityCode',
        :'change_order_bill_form_name' => :'changeOrderBillFormName',
        :'change_order_notice_name' => :'changeOrderNoticeName',
        :'ship_label_name' => :'shipLabelName',
        :'planning_form_name' => :'planningFormName',
        :'stock_ticket_name' => :'stockTicketName',
        :'wip_entry_format' => :'wipEntryFormat',
        :'change_order_name' => :'changeOrderName',
        :'order_confirm_name' => :'orderConfirmName',
        :'ship_ticket_name' => :'shipTicketName',
        :'show_change_order_amounts' => :'showChangeOrderAmounts',
        :'relieve_partial_wip_per_part' => :'relievePartialWipPerPart',
        :'use_variable_markup' => :'useVariableMarkup',
        :'check_planned_work' => :'checkPlannedWork',
        :'last_action_from_job_cost' => :'lastActionFromJobCost'
      }
    end
  end
end
