module Pace
  class SecurityFilterRelationType < Base
    attr_accessor :name

    attr_accessor :field

    attr_accessor :id

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :data_object

    attr_accessor :system_generated


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'field' => :'field',
        :'id' => :'id',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'data_object' => :'dataObject',
        :'system_generated' => :'systemGenerated'
      }
    end
  end
end
