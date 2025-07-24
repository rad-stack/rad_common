module Pace
  class ReportPackage < Base
    attr_accessor :_module

    attr_accessor :id

    attr_accessor :display_name

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :system_generated

    attr_accessor :base_object

    attr_accessor :include_in_context_x_path

    attr_accessor :suppress_include_prompt


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'_module' => :'module',
        :'id' => :'id',
        :'display_name' => :'displayName',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'system_generated' => :'systemGenerated',
        :'base_object' => :'baseObject',
        :'include_in_context_x_path' => :'includeInContextXPath',
        :'suppress_include_prompt' => :'suppressIncludePrompt'
      }
    end
  end
end
