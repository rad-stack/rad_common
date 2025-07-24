module Pace
  class EstimateRequestPrepressOp < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :quantity

    attr_accessor :customer_viewable

    attr_accessor :quantity_forced

    attr_accessor :unit_label_forced

    attr_accessor :prepress_item

    attr_accessor :prep_activity

    attr_accessor :estimate_request_part


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'quantity' => :'quantity',
        :'customer_viewable' => :'customerViewable',
        :'quantity_forced' => :'quantityForced',
        :'unit_label_forced' => :'unitLabelForced',
        :'prepress_item' => :'prepressItem',
        :'prep_activity' => :'prepActivity',
        :'estimate_request_part' => :'estimateRequestPart'
      }
    end
  end
end
