module Pace
  class QuestionnaireStatus < Base
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


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
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
        :'deletable' => :'deletable'
      }
    end
  end
end
