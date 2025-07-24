module Pace
  class TopicQuestion < Base
    attr_accessor :id

    attr_accessor :default_value

    attr_accessor :active

    attr_accessor :filter

    attr_accessor :description

    attr_accessor :required

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_option

    attr_accessor :sequence

    attr_accessor :topic

    attr_accessor :default_type

    attr_accessor :question

    attr_accessor :default_and_skip

    attr_accessor :is_default_editable


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'default_value' => :'defaultValue',
        :'active' => :'active',
        :'filter' => :'filter',
        :'description' => :'description',
        :'required' => :'required',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_option' => :'defaultOption',
        :'sequence' => :'sequence',
        :'topic' => :'topic',
        :'default_type' => :'defaultType',
        :'question' => :'question',
        :'default_and_skip' => :'defaultAndSkip',
        :'is_default_editable' => :'isDefaultEditable'
      }
    end
  end
end
