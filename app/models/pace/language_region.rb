module Pace
  class LanguageRegion < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :language

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :subtag

    attr_accessor :translation_version


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'language' => :'language',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'subtag' => :'subtag',
        :'translation_version' => :'translationVersion'
      }
    end
  end
end
