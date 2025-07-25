module Pace
  class CRMStatus < Base
    attr_accessor :open

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :activity

    attr_accessor :campaign

    attr_accessor :status_type

    attr_accessor :close_from_opportunity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'open' => :'open',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'activity' => :'activity',
        :'campaign' => :'campaign',
        :'status_type' => :'statusType',
        :'close_from_opportunity' => :'closeFromOpportunity'
      }
    end
  end
end
