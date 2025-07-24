module Pace
  class Language < Base
    attr_accessor :name

    attr_accessor :native_name

    attr_accessor :id

    attr_accessor :active

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
        :'native_name' => :'nativeName',
        :'id' => :'id',
        :'active' => :'active',
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
