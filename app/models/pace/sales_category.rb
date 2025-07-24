module Pace
  class SalesCategory < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :gl_account

    attr_accessor :taxable

    attr_accessor :tax_report

    attr_accessor :old_gl_location

    attr_accessor :old_gl_account

    attr_accessor :sales_report

    attr_accessor :auto_amt_in_bill

    attr_accessor :include_in_discount

    attr_accessor :commissionable

    attr_accessor :auto_percent_in_bill

    attr_accessor :commission


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'gl_account' => :'glAccount',
        :'taxable' => :'taxable',
        :'tax_report' => :'taxReport',
        :'old_gl_location' => :'oldGLLocation',
        :'old_gl_account' => :'oldGLAccount',
        :'sales_report' => :'salesReport',
        :'auto_amt_in_bill' => :'autoAmtInBill',
        :'include_in_discount' => :'includeInDiscount',
        :'commissionable' => :'commissionable',
        :'auto_percent_in_bill' => :'autoPercentInBill',
        :'commission' => :'commission'
      }
    end
  end
end
