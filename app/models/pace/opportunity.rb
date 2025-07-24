module Pace
  class Opportunity < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :description

    attr_accessor :activity

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :source_type

    attr_accessor :probability

    attr_accessor :amount

    attr_accessor :customer

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :estimate

    attr_accessor :assigned_to

    attr_accessor :actual_cost

    attr_accessor :estimate_request

    attr_accessor :expected_close_date

    attr_accessor :sales_stage

    attr_accessor :quote_number

    attr_accessor :opportunity_type

    attr_accessor :won_amount

    attr_accessor :closed_date

    attr_accessor :campaign

    attr_accessor :next_step

    attr_accessor :won_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'description' => :'description',
        :'activity' => :'activity',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'source_type' => :'sourceType',
        :'probability' => :'probability',
        :'amount' => :'amount',
        :'customer' => :'customer',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'estimate' => :'estimate',
        :'assigned_to' => :'assignedTo',
        :'actual_cost' => :'actualCost',
        :'estimate_request' => :'estimateRequest',
        :'expected_close_date' => :'expectedCloseDate',
        :'sales_stage' => :'salesStage',
        :'quote_number' => :'quoteNumber',
        :'opportunity_type' => :'opportunityType',
        :'won_amount' => :'wonAmount',
        :'closed_date' => :'closedDate',
        :'campaign' => :'campaign',
        :'next_step' => :'nextStep',
        :'won_date' => :'wonDate'
      }
    end
  end
end
