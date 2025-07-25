module Pace
  class CountryGroupMember < Base
    attr_accessor :country

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :country_group


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'country' => :'country',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'country_group' => :'countryGroup'
      }
    end
  end
end
