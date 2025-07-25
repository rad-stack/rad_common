module Pace
  class Question < Base
    attr_accessor :id

    attr_accessor :default_value

    attr_accessor :attribute

    attr_accessor :filter

    attr_accessor :attribute_type

    attr_accessor :description

    attr_accessor :required

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :option_list

    attr_accessor :default_option

    attr_accessor :maxlength

    attr_accessor :foreign_key

    attr_accessor :question_type

    attr_accessor :default_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'default_value' => :'defaultValue',
        :'attribute' => :'attribute',
        :'filter' => :'filter',
        :'attribute_type' => :'attributeType',
        :'description' => :'description',
        :'required' => :'required',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'option_list' => :'optionList',
        :'default_option' => :'defaultOption',
        :'maxlength' => :'maxlength',
        :'foreign_key' => :'foreignKey',
        :'question_type' => :'questionType',
        :'default_type' => :'defaultType'
      }
    end
  end
end
