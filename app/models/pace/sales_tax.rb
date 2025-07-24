module Pace
  class SalesTax < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :tax_num

    attr_accessor :tax_report

    attr_accessor :sls_tax_email

    attr_accessor :tax_report_category

    attr_accessor :actual_cost_based_taxing

    attr_accessor :self_tax

    attr_accessor :alt_name

    attr_accessor :tax_report_category_ap

    attr_accessor :rate4

    attr_accessor :rate5

    attr_accessor :rate6

    attr_accessor :rate7

    attr_accessor :rate1

    attr_accessor :rate2

    attr_accessor :rate3

    attr_accessor :sls_tax_notes

    attr_accessor :calculate_canadian_sales_tax

    attr_accessor :tax_rate

    attr_accessor :taxable_limit


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'tax_num' => :'taxNum',
        :'tax_report' => :'taxReport',
        :'sls_tax_email' => :'slsTaxEmail',
        :'tax_report_category' => :'taxReportCategory',
        :'actual_cost_based_taxing' => :'actualCostBasedTaxing',
        :'self_tax' => :'selfTax',
        :'alt_name' => :'altName',
        :'tax_report_category_ap' => :'taxReportCategoryAP',
        :'rate4' => :'rate4',
        :'rate5' => :'rate5',
        :'rate6' => :'rate6',
        :'rate7' => :'rate7',
        :'rate1' => :'rate1',
        :'rate2' => :'rate2',
        :'rate3' => :'rate3',
        :'sls_tax_notes' => :'slsTaxNotes',
        :'calculate_canadian_sales_tax' => :'calculateCanadianSalesTax',
        :'tax_rate' => :'taxRate',
        :'taxable_limit' => :'taxableLimit'
      }
    end
  end
end
