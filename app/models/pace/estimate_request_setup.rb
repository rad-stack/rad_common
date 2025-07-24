module Pace
  class EstimateRequestSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_status_converted_request

    attr_accessor :default_status_conversion_fail

    attr_accessor :default_estimate_status

    attr_accessor :default_status_converted_questionnaire_product


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_status_converted_request' => :'defaultStatusConvertedRequest',
        :'default_status_conversion_fail' => :'defaultStatusConversionFail',
        :'default_estimate_status' => :'defaultEstimateStatus',
        :'default_status_converted_questionnaire_product' => :'defaultStatusConvertedQuestionnaireProduct'
      }
    end
  end
end
