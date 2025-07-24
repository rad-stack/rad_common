module Pace
  class ImportTemplateObjectNode < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :import_template

    attr_accessor :relation_path

    attr_accessor :search_path

    attr_accessor :action

    attr_accessor :object_name

    attr_accessor :search_path_forced

    attr_accessor :use_previous


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'import_template' => :'importTemplate',
        :'relation_path' => :'relationPath',
        :'search_path' => :'searchPath',
        :'action' => :'action',
        :'object_name' => :'objectName',
        :'search_path_forced' => :'searchPathForced',
        :'use_previous' => :'usePrevious'
      }
    end
  end
end
