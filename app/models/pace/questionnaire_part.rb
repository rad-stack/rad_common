module Pace
  class QuestionnairePart < Base
    attr_accessor :id

    attr_accessor :source

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_request_product

    attr_accessor :questionnaire_product

    attr_accessor :questionnaire_type

    attr_accessor :part


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'source' => :'source',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_request_product' => :'estimateRequestProduct',
        :'questionnaire_product' => :'questionnaireProduct',
        :'questionnaire_type' => :'questionnaireType',
        :'part' => :'part'
      }
    end
  end
end
