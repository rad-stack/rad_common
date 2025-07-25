module Pace
  class EstimateRequestStatus < Base
    attr_accessor :open

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :editable

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :status_type

    attr_accessor :convertible

    attr_accessor :deletable

    attr_accessor :trigger_crm_opportunity

    attr_accessor :user_available

    attr_accessor :trigger_crm_activity

    attr_accessor :cascade_status_to_product

    attr_accessor :trigger_questionnaire_status_change


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'open' => :'open',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'editable' => :'editable',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'status_type' => :'statusType',
        :'convertible' => :'convertible',
        :'deletable' => :'deletable',
        :'trigger_crm_opportunity' => :'triggerCRMOpportunity',
        :'user_available' => :'userAvailable',
        :'trigger_crm_activity' => :'triggerCRMActivity',
        :'cascade_status_to_product' => :'cascadeStatusToProduct',
        :'trigger_questionnaire_status_change' => :'triggerQuestionnaireStatusChange'
      }
    end
  end
end
