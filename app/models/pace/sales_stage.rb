module Pace
  class SalesStage < Base
    attr_accessor :open

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :close_activity

    attr_accessor :next_step


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
        :'close_activity' => :'closeActivity',
        :'next_step' => :'nextStep'
      }
    end
  end
end
