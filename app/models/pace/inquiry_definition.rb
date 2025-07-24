module Pace
  class InquiryDefinition < Base
    attr_accessor :id

    attr_accessor :definition

    attr_accessor :converted

    attr_accessor :description

    attr_accessor :group

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :show_on_dashboard

    attr_accessor :last_accessed_date

    attr_accessor :user

    attr_accessor :definition_object

    attr_accessor :definition_xml


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'definition' => :'definition',
        :'converted' => :'converted',
        :'description' => :'description',
        :'group' => :'group',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'show_on_dashboard' => :'showOnDashboard',
        :'last_accessed_date' => :'lastAccessedDate',
        :'user' => :'user',
        :'definition_object' => :'definitionObject',
        :'definition_xml' => :'definitionXML'
      }
    end
  end
end
