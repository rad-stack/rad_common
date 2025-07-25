module Pace
  class GLAccount < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :line_position

    attr_accessor :amount_column_code

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :interface_jc

    attr_accessor :account

    attr_accessor :report_underline_style

    attr_accessor :account_type

    attr_accessor :pending_balance

    attr_accessor :report_heading_style

    attr_accessor :posted_balance

    attr_accessor :level_code

    attr_accessor :import_id

    attr_accessor :report_code

    attr_accessor :auto_post_amt

    attr_accessor :report_font_style

    attr_accessor :normal_sign

    attr_accessor :current_period_balance

    attr_accessor :income_statement_account

    attr_accessor :report_font_size

    attr_accessor :export_id

    attr_accessor :outside_purchase


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'line_position' => :'linePosition',
        :'amount_column_code' => :'amountColumnCode',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'interface_jc' => :'interfaceJC',
        :'account' => :'account',
        :'report_underline_style' => :'reportUnderlineStyle',
        :'account_type' => :'accountType',
        :'pending_balance' => :'pendingBalance',
        :'report_heading_style' => :'reportHeadingStyle',
        :'posted_balance' => :'postedBalance',
        :'level_code' => :'levelCode',
        :'import_id' => :'importID',
        :'report_code' => :'reportCode',
        :'auto_post_amt' => :'autoPostAmt',
        :'report_font_style' => :'reportFontStyle',
        :'normal_sign' => :'normalSign',
        :'current_period_balance' => :'currentPeriodBalance',
        :'income_statement_account' => :'incomeStatementAccount',
        :'report_font_size' => :'reportFontSize',
        :'export_id' => :'exportID',
        :'outside_purchase' => :'outsidePurchase'
      }
    end
  end
end
