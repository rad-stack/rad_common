module Pace
  class DunningLetter < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :dunning_salutation_aging

    attr_accessor :dunning_closing_aging

    attr_accessor :dunning_body_aging

    attr_accessor :dunning_intro_aging


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'dunning_salutation_aging' => :'dunningSalutationAging',
        :'dunning_closing_aging' => :'dunningClosingAging',
        :'dunning_body_aging' => :'dunningBodyAging',
        :'dunning_intro_aging' => :'dunningIntroAging'
      }
    end
  end
end
