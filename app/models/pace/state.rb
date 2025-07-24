module Pace
  class State < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :country

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :sales_tax

    attr_accessor :show_ssn

    attr_accessor :state_account_number

    attr_accessor :state_tax_limit

    attr_accessor :double_time_after12_hours

    attr_accessor :sales_tax_calculation_basis

    attr_accessor :state_tax_rate

    attr_accessor :state_tax_id

    attr_accessor :seventh_day_doubletime


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'country' => :'country',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'sales_tax' => :'salesTax',
        :'show_ssn' => :'showSSN',
        :'state_account_number' => :'stateAccountNumber',
        :'state_tax_limit' => :'stateTaxLimit',
        :'double_time_after12_hours' => :'doubleTimeAfter12Hours',
        :'sales_tax_calculation_basis' => :'salesTaxCalculationBasis',
        :'state_tax_rate' => :'stateTaxRate',
        :'state_tax_id' => :'stateTaxID',
        :'seventh_day_doubletime' => :'seventhDayDoubletime'
      }
    end
  end
end
