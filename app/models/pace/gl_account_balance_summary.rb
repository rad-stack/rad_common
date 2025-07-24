module Pace
  class GLAccountBalanceSummary < Base
    attr_accessor :id

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_accounting_period

    attr_accessor :gl_account

    attr_accessor :period_range

    attr_accessor :open_balance

    attr_accessor :change_balance

    attr_accessor :end_budget_balance

    attr_accessor :change_balance_un_posted

    attr_accessor :end_budget_variance

    attr_accessor :period_status

    attr_accessor :budget_balance

    attr_accessor :end_balance_un_posted

    attr_accessor :open_budget_balance

    attr_accessor :end_balance

    attr_accessor :budget_variance

    attr_accessor :open_budget_variance


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'gl_account' => :'glAccount',
        :'period_range' => :'periodRange',
        :'open_balance' => :'openBalance',
        :'change_balance' => :'changeBalance',
        :'end_budget_balance' => :'endBudgetBalance',
        :'change_balance_un_posted' => :'changeBalanceUnPosted',
        :'end_budget_variance' => :'endBudgetVariance',
        :'period_status' => :'periodStatus',
        :'budget_balance' => :'budgetBalance',
        :'end_balance_un_posted' => :'endBalanceUnPosted',
        :'open_budget_balance' => :'openBudgetBalance',
        :'end_balance' => :'endBalance',
        :'budget_variance' => :'budgetVariance',
        :'open_budget_variance' => :'openBudgetVariance'
      }
    end
  end
end
