module Pace
  class Campaign < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :start_date

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :assigned_to

    attr_accessor :actual_cost

    attr_accessor :end_date

    attr_accessor :budget_amount

    attr_accessor :campaign_type

    attr_accessor :expected_cost_amount

    attr_accessor :call_to_action

    attr_accessor :objective

    attr_accessor :actual_revenue

    attr_accessor :expected_revenue_amount


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'start_date' => :'startDate',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'assigned_to' => :'assignedTo',
        :'actual_cost' => :'actualCost',
        :'end_date' => :'endDate',
        :'budget_amount' => :'budgetAmount',
        :'campaign_type' => :'campaignType',
        :'expected_cost_amount' => :'expectedCostAmount',
        :'call_to_action' => :'callToAction',
        :'objective' => :'objective',
        :'actual_revenue' => :'actualRevenue',
        :'expected_revenue_amount' => :'expectedRevenueAmount'
      }
    end
  end
end
