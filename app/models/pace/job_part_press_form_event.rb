module Pace
  class JobPartPressFormEvent < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :fiery_property_value

    attr_accessor :fiery_property_value_description

    attr_accessor :press_event

    attr_accessor :created_from_split

    attr_accessor :prints

    attr_accessor :fiery_property_description

    attr_accessor :fiery_property

    attr_accessor :jobpartpressform


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'fiery_property_value' => :'fieryPropertyValue',
        :'fiery_property_value_description' => :'fieryPropertyValueDescription',
        :'press_event' => :'pressEvent',
        :'created_from_split' => :'createdFromSplit',
        :'prints' => :'prints',
        :'fiery_property_description' => :'fieryPropertyDescription',
        :'fiery_property' => :'fieryProperty',
        :'jobpartpressform' => :'jobpartpressform'
      }
    end
  end
end
