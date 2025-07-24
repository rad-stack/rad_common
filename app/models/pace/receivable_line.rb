module Pace
  class ReceivableLine < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :sales_category

    attr_accessor :sales_person

    attr_accessor :sales_tax

    attr_accessor :tax_category

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :original_id

    attr_accessor :tax_base

    attr_accessor :tax_report_month

    attr_accessor :receivable

    attr_accessor :commission_base

    attr_accessor :entry_type

    attr_accessor :tax_rate7_amount

    attr_accessor :tax_rate4_amount

    attr_accessor :tax_rate22_amount

    attr_accessor :tax_rate17_amount

    attr_accessor :tax_rate14_amount

    attr_accessor :tax_rate21_amount

    attr_accessor :tax_rate5_amount

    attr_accessor :tax_rate15_amount

    attr_accessor :tax_rate16_amount

    attr_accessor :tax_rate13_amount

    attr_accessor :tax_rate23_amount

    attr_accessor :tax_rate10_amount

    attr_accessor :tax_rate20_amount

    attr_accessor :tax_rate6_amount

    attr_accessor :tax_rate3_amount

    attr_accessor :tax_rate11_amount

    attr_accessor :tax_rate18_amount

    attr_accessor :tax_rate1_amount

    attr_accessor :tax_rate25_amount

    attr_accessor :tax_rate9_amount

    attr_accessor :tax_rate12_amount

    attr_accessor :tax_rate2_amount

    attr_accessor :tax_rate24_amount

    attr_accessor :tax_rate8_amount

    attr_accessor :tax_rate19_amount

    attr_accessor :overall_billling_journal_entry

    attr_accessor :city_county_report_code

    attr_accessor :overall_billing_comm_journal_entry

    attr_accessor :overall_billing_comm_offset_journal_entry

    attr_accessor :amounts_updated


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'sales_category' => :'salesCategory',
        :'sales_person' => :'salesPerson',
        :'sales_tax' => :'salesTax',
        :'tax_category' => :'taxCategory',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'original_id' => :'originalId',
        :'tax_base' => :'taxBase',
        :'tax_report_month' => :'taxReportMonth',
        :'receivable' => :'receivable',
        :'commission_base' => :'commissionBase',
        :'entry_type' => :'entryType',
        :'tax_rate7_amount' => :'taxRate7Amount',
        :'tax_rate4_amount' => :'taxRate4Amount',
        :'tax_rate22_amount' => :'taxRate22Amount',
        :'tax_rate17_amount' => :'taxRate17Amount',
        :'tax_rate14_amount' => :'taxRate14Amount',
        :'tax_rate21_amount' => :'taxRate21Amount',
        :'tax_rate5_amount' => :'taxRate5Amount',
        :'tax_rate15_amount' => :'taxRate15Amount',
        :'tax_rate16_amount' => :'taxRate16Amount',
        :'tax_rate13_amount' => :'taxRate13Amount',
        :'tax_rate23_amount' => :'taxRate23Amount',
        :'tax_rate10_amount' => :'taxRate10Amount',
        :'tax_rate20_amount' => :'taxRate20Amount',
        :'tax_rate6_amount' => :'taxRate6Amount',
        :'tax_rate3_amount' => :'taxRate3Amount',
        :'tax_rate11_amount' => :'taxRate11Amount',
        :'tax_rate18_amount' => :'taxRate18Amount',
        :'tax_rate1_amount' => :'taxRate1Amount',
        :'tax_rate25_amount' => :'taxRate25Amount',
        :'tax_rate9_amount' => :'taxRate9Amount',
        :'tax_rate12_amount' => :'taxRate12Amount',
        :'tax_rate2_amount' => :'taxRate2Amount',
        :'tax_rate24_amount' => :'taxRate24Amount',
        :'tax_rate8_amount' => :'taxRate8Amount',
        :'tax_rate19_amount' => :'taxRate19Amount',
        :'overall_billling_journal_entry' => :'overallBilllingJournalEntry',
        :'city_county_report_code' => :'cityCountyReportCode',
        :'overall_billing_comm_journal_entry' => :'overallBillingCommJournalEntry',
        :'overall_billing_comm_offset_journal_entry' => :'overallBillingCommOffsetJournalEntry',
        :'amounts_updated' => :'amountsUpdated'
      }
    end
  end
end
