module Pace
  class TaxReportPeriod < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :created_date

    attr_accessor :tax_report

    attr_accessor :last_refresh_date_time

    attr_accessor :tax_obligation_period_key

    attr_accessor :tax_obligation_start

    attr_accessor :public_ip

    attr_accessor :tax_obligation_due

    attr_accessor :tax_return_payment_indicator

    attr_accessor :window_size

    attr_accessor :tax_year

    attr_accessor :tax_return_charge_ref_number

    attr_accessor :screen_resolution

    attr_accessor :browser_plugins

    attr_accessor :period

    attr_accessor :agreed_to_legal_declaration

    attr_accessor :tax_reported

    attr_accessor :tax_return_processing_date

    attr_accessor :tax_obligation_end

    attr_accessor :tax_return_form_bundle_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'created_date' => :'createdDate',
        :'tax_report' => :'taxReport',
        :'last_refresh_date_time' => :'lastRefreshDateTime',
        :'tax_obligation_period_key' => :'taxObligationPeriodKey',
        :'tax_obligation_start' => :'taxObligationStart',
        :'public_ip' => :'publicIP',
        :'tax_obligation_due' => :'taxObligationDue',
        :'tax_return_payment_indicator' => :'taxReturnPaymentIndicator',
        :'window_size' => :'windowSize',
        :'tax_year' => :'taxYear',
        :'tax_return_charge_ref_number' => :'taxReturnChargeRefNumber',
        :'screen_resolution' => :'screenResolution',
        :'browser_plugins' => :'browserPlugins',
        :'period' => :'period',
        :'agreed_to_legal_declaration' => :'agreedToLegalDeclaration',
        :'tax_reported' => :'taxReported',
        :'tax_return_processing_date' => :'taxReturnProcessingDate',
        :'tax_obligation_end' => :'taxObligationEnd',
        :'tax_return_form_bundle_number' => :'taxReturnFormBundleNumber'
      }
    end
  end
end
