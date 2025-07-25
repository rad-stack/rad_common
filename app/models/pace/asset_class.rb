module Pace
  class AssetClass < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :fa_setup_id

    attr_accessor :useful_life_book

    attr_accessor :useful_life_tax


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'fa_setup_id' => :'faSetupID',
        :'useful_life_book' => :'usefulLifeBook',
        :'useful_life_tax' => :'usefulLifeTax'
      }
    end
  end
end
