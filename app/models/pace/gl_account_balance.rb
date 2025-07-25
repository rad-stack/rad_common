module Pace
  class GLAccountBalance < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :gl_accounting_period

    attr_accessor :gl_account

    attr_accessor :budget_amount

    attr_accessor :end_budget_balance

    attr_accessor :end_balance_un_posted

    attr_accessor :end_balance

    attr_accessor :open_bal

    attr_accessor :open_budget_amount

    attr_accessor :chng_bal_un_posted

    attr_accessor :chng_bal


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'gl_account' => :'glAccount',
        :'budget_amount' => :'budgetAmount',
        :'end_budget_balance' => :'endBudgetBalance',
        :'end_balance_un_posted' => :'endBalanceUnPosted',
        :'end_balance' => :'endBalance',
        :'open_bal' => :'openBal',
        :'open_budget_amount' => :'openBudgetAmount',
        :'chng_bal_un_posted' => :'chngBalUnPosted',
        :'chng_bal' => :'chngBal'
      }
    end
  end
end
