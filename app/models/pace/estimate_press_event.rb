module Pace
  class EstimatePressEvent < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :item_template

    attr_accessor :fiery_property_value

    attr_accessor :fiery_property_value_description

    attr_accessor :estimate_press

    attr_accessor :press_event

    attr_accessor :created_from_split

    attr_accessor :auto_change

    attr_accessor :prints

    attr_accessor :fiery_property_description

    attr_accessor :finishing_operation

    attr_accessor :fiery_property


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'item_template' => :'itemTemplate',
        :'fiery_property_value' => :'fieryPropertyValue',
        :'fiery_property_value_description' => :'fieryPropertyValueDescription',
        :'estimate_press' => :'estimatePress',
        :'press_event' => :'pressEvent',
        :'created_from_split' => :'createdFromSplit',
        :'auto_change' => :'autoChange',
        :'prints' => :'prints',
        :'fiery_property_description' => :'fieryPropertyDescription',
        :'finishing_operation' => :'finishingOperation',
        :'fiery_property' => :'fieryProperty'
      }
    end
  end
end
