module Pace
  class ImportElement < Base
    attr_accessor :name

    attr_accessor :value

    attr_accessor :id

    attr_accessor :header

    attr_accessor :parameter

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :import_template

    attr_accessor :import_control

    attr_accessor :look_up

    attr_accessor :mapped_field_x_path


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'value' => :'value',
        :'id' => :'id',
        :'header' => :'header',
        :'parameter' => :'parameter',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'import_template' => :'importTemplate',
        :'import_control' => :'importControl',
        :'look_up' => :'lookUp',
        :'mapped_field_x_path' => :'mappedFieldXPath'
      }
    end
  end
end
