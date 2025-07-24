module Pace
  class ItemTemplateComboLink < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :quantity_multiplier

    attr_accessor :combo_item_template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'combo_item_template' => :'comboItemTemplate'
      }
    end
  end
end
