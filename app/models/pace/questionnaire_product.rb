module Pace
  class QuestionnaireProduct < Base
    attr_accessor :id

    attr_accessor :source

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :entered_by

    attr_accessor :user_interface_set

    attr_accessor :total_parts

    attr_accessor :entry_date_time

    attr_accessor :estimate_request_product


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'source' => :'source',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'entered_by' => :'enteredBy',
        :'user_interface_set' => :'userInterfaceSet',
        :'total_parts' => :'totalParts',
        :'entry_date_time' => :'entryDateTime',
        :'estimate_request_product' => :'estimateRequestProduct'
      }
    end
  end
end
