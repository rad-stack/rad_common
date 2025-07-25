module Pace
  class AssetPostingGroup < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :impairment_account

    attr_accessor :disposal_gain_loss_account

    attr_accessor :disposal_cost_account

    attr_accessor :maintenance_expense_account

    attr_accessor :depreciation_expense_account

    attr_accessor :disposal_accum_dep_account

    attr_accessor :acquisition_cost_account

    attr_accessor :accumulated_depreciation_account


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'impairment_account' => :'impairmentAccount',
        :'disposal_gain_loss_account' => :'disposalGainLossAccount',
        :'disposal_cost_account' => :'disposalCostAccount',
        :'maintenance_expense_account' => :'maintenanceExpenseAccount',
        :'depreciation_expense_account' => :'depreciationExpenseAccount',
        :'disposal_accum_dep_account' => :'disposalAccumDepAccount',
        :'acquisition_cost_account' => :'acquisitionCostAccount',
        :'accumulated_depreciation_account' => :'accumulatedDepreciationAccount'
      }
    end
  end
end
