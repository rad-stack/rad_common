module Pace
  class InvoiceTaxDist < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :state_key

    attr_accessor :taxable_code

    attr_accessor :zip

    attr_accessor :sales_tax

    attr_accessor :tax_category

    attr_accessor :manual

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :tax_base

    attr_accessor :rate4

    attr_accessor :rate5

    attr_accessor :rate6

    attr_accessor :rate7

    attr_accessor :rate1

    attr_accessor :rate2

    attr_accessor :rate3

    attr_accessor :tax_rate

    attr_accessor :taxable_limit

    attr_accessor :invoice

    attr_accessor :memo_created

    attr_accessor :memo_created_date

    attr_accessor :lock_amount

    attr_accessor :adjusted_total

    attr_accessor :amount_adjustment

    attr_accessor :job_shipment

    attr_accessor :external_code_for_handling_charge

    attr_accessor :external_code_for_tax

    attr_accessor :city_county_report_code

    attr_accessor :carton_content

    attr_accessor :freight

    attr_accessor :edited

    attr_accessor :quantity_shipped

    attr_accessor :distribution_remaining

    attr_accessor :tax_base_adjustment

    attr_accessor :lock_tax_base

    attr_accessor :rate21

    attr_accessor :rate20

    attr_accessor :rate16

    attr_accessor :rate15

    attr_accessor :rate18

    attr_accessor :rate17

    attr_accessor :rate12

    attr_accessor :rate11

    attr_accessor :rate14

    attr_accessor :rate13

    attr_accessor :rate19

    attr_accessor :rate8

    attr_accessor :rate9

    attr_accessor :name6

    attr_accessor :name25

    attr_accessor :name5

    attr_accessor :name24

    attr_accessor :name4

    attr_accessor :name23

    attr_accessor :name3

    attr_accessor :name22

    attr_accessor :rate23

    attr_accessor :name21

    attr_accessor :name9

    attr_accessor :rate22

    attr_accessor :name20

    attr_accessor :name8

    attr_accessor :rate25

    attr_accessor :name7

    attr_accessor :rate24

    attr_accessor :name2

    attr_accessor :name1

    attr_accessor :adjustment_tax_dist

    attr_accessor :freight_adjustment

    attr_accessor :adjusted_amount

    attr_accessor :handling_adjustment

    attr_accessor :invoice_line_reference

    attr_accessor :tax_freight_and_handling

    attr_accessor :calculation_error

    attr_accessor :includes_handling

    attr_accessor :adjusted_freight

    attr_accessor :tax_freight_and_handling_adjustment

    attr_accessor :adjusted_carton_content

    attr_accessor :adjusted_handling

    attr_accessor :shipment_distribution

    attr_accessor :tax_freight_adjustment

    attr_accessor :invoice_extra_reference

    attr_accessor :name19

    attr_accessor :name18

    attr_accessor :name17

    attr_accessor :name16

    attr_accessor :name15

    attr_accessor :name14

    attr_accessor :name13

    attr_accessor :name12

    attr_accessor :name11

    attr_accessor :name10

    attr_accessor :forced_tax_dist

    attr_accessor :tax_freight

    attr_accessor :rate10

    attr_accessor :handling


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'state_key' => :'stateKey',
        :'taxable_code' => :'taxableCode',
        :'zip' => :'zip',
        :'sales_tax' => :'salesTax',
        :'tax_category' => :'taxCategory',
        :'manual' => :'manual',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'tax_base' => :'taxBase',
        :'rate4' => :'rate4',
        :'rate5' => :'rate5',
        :'rate6' => :'rate6',
        :'rate7' => :'rate7',
        :'rate1' => :'rate1',
        :'rate2' => :'rate2',
        :'rate3' => :'rate3',
        :'tax_rate' => :'taxRate',
        :'taxable_limit' => :'taxableLimit',
        :'invoice' => :'invoice',
        :'memo_created' => :'memoCreated',
        :'memo_created_date' => :'memoCreatedDate',
        :'lock_amount' => :'lockAmount',
        :'adjusted_total' => :'adjustedTotal',
        :'amount_adjustment' => :'amountAdjustment',
        :'job_shipment' => :'jobShipment',
        :'external_code_for_handling_charge' => :'externalCodeForHandlingCharge',
        :'external_code_for_tax' => :'externalCodeForTax',
        :'city_county_report_code' => :'cityCountyReportCode',
        :'carton_content' => :'cartonContent',
        :'freight' => :'freight',
        :'edited' => :'edited',
        :'quantity_shipped' => :'quantityShipped',
        :'distribution_remaining' => :'distributionRemaining',
        :'tax_base_adjustment' => :'taxBaseAdjustment',
        :'lock_tax_base' => :'lockTaxBase',
        :'rate21' => :'rate21',
        :'rate20' => :'rate20',
        :'rate16' => :'rate16',
        :'rate15' => :'rate15',
        :'rate18' => :'rate18',
        :'rate17' => :'rate17',
        :'rate12' => :'rate12',
        :'rate11' => :'rate11',
        :'rate14' => :'rate14',
        :'rate13' => :'rate13',
        :'rate19' => :'rate19',
        :'rate8' => :'rate8',
        :'rate9' => :'rate9',
        :'name6' => :'name6',
        :'name25' => :'name25',
        :'name5' => :'name5',
        :'name24' => :'name24',
        :'name4' => :'name4',
        :'name23' => :'name23',
        :'name3' => :'name3',
        :'name22' => :'name22',
        :'rate23' => :'rate23',
        :'name21' => :'name21',
        :'name9' => :'name9',
        :'rate22' => :'rate22',
        :'name20' => :'name20',
        :'name8' => :'name8',
        :'rate25' => :'rate25',
        :'name7' => :'name7',
        :'rate24' => :'rate24',
        :'name2' => :'name2',
        :'name1' => :'name1',
        :'adjustment_tax_dist' => :'adjustmentTaxDist',
        :'freight_adjustment' => :'freightAdjustment',
        :'adjusted_amount' => :'adjustedAmount',
        :'handling_adjustment' => :'handlingAdjustment',
        :'invoice_line_reference' => :'invoiceLineReference',
        :'tax_freight_and_handling' => :'taxFreightAndHandling',
        :'calculation_error' => :'calculationError',
        :'includes_handling' => :'includesHandling',
        :'adjusted_freight' => :'adjustedFreight',
        :'tax_freight_and_handling_adjustment' => :'taxFreightAndHandlingAdjustment',
        :'adjusted_carton_content' => :'adjustedCartonContent',
        :'adjusted_handling' => :'adjustedHandling',
        :'shipment_distribution' => :'shipmentDistribution',
        :'tax_freight_adjustment' => :'taxFreightAdjustment',
        :'invoice_extra_reference' => :'invoiceExtraReference',
        :'name19' => :'name19',
        :'name18' => :'name18',
        :'name17' => :'name17',
        :'name16' => :'name16',
        :'name15' => :'name15',
        :'name14' => :'name14',
        :'name13' => :'name13',
        :'name12' => :'name12',
        :'name11' => :'name11',
        :'name10' => :'name10',
        :'forced_tax_dist' => :'forcedTaxDist',
        :'tax_freight' => :'taxFreight',
        :'rate10' => :'rate10',
        :'handling' => :'handling'
      }
    end
  end
end
