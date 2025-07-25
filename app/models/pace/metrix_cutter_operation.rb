module Pace
  class MetrixCutterOperation < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :use_as_size

    attr_accessor :alias_names

    attr_accessor :use_as_outline


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'use_as_size' => :'useAsSize',
        :'alias_names' => :'aliasNames',
        :'use_as_outline' => :'useAsOutline'
      }
    end
  end
end
