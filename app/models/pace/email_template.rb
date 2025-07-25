module Pace
  class EmailTemplate < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :system_generated

    attr_accessor :base_object

    attr_accessor :default_template

    attr_accessor :plain_text

    attr_accessor :html

    attr_accessor :available_for_system_email


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'system_generated' => :'systemGenerated',
        :'base_object' => :'baseObject',
        :'default_template' => :'defaultTemplate',
        :'plain_text' => :'plainText',
        :'html' => :'html',
        :'available_for_system_email' => :'availableForSystemEmail'
      }
    end
  end
end
