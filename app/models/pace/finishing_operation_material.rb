module Pace
  class FinishingOperationMaterial < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :setup_time

    attr_accessor :show_pick_widget

    attr_accessor :unit_label

    attr_accessor :show_filtered_inventory_items

    attr_accessor :default_note

    attr_accessor :default_material

    attr_accessor :ask_quantity

    attr_accessor :quantity_calculation

    attr_accessor :option_list

    attr_accessor :default_option

    attr_accessor :xpath_expression

    attr_accessor :quantity_per_unit

    attr_accessor :ask_material

    attr_accessor :prod_group_sub_key

    attr_accessor :ask_vendor

    attr_accessor :speed_adjustment

    attr_accessor :product_group

    attr_accessor :ask_list

    attr_accessor :sub_product_group

    attr_accessor :default_vendor

    attr_accessor :inventory_item_filter_tags

    attr_accessor :option

    attr_accessor :sequence

    attr_accessor :finishing_operation

    attr_accessor :inventory_item

    attr_accessor :show_related_inventory_items

    attr_accessor :ask_note


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'setup_time' => :'setupTime',
        :'show_pick_widget' => :'showPickWidget',
        :'unit_label' => :'unitLabel',
        :'show_filtered_inventory_items' => :'showFilteredInventoryItems',
        :'default_note' => :'defaultNote',
        :'default_material' => :'defaultMaterial',
        :'ask_quantity' => :'askQuantity',
        :'quantity_calculation' => :'quantityCalculation',
        :'option_list' => :'optionList',
        :'default_option' => :'defaultOption',
        :'xpath_expression' => :'xpathExpression',
        :'quantity_per_unit' => :'quantityPerUnit',
        :'ask_material' => :'askMaterial',
        :'prod_group_sub_key' => :'prodGroupSubKey',
        :'ask_vendor' => :'askVendor',
        :'speed_adjustment' => :'speedAdjustment',
        :'product_group' => :'productGroup',
        :'ask_list' => :'askList',
        :'sub_product_group' => :'subProductGroup',
        :'default_vendor' => :'defaultVendor',
        :'inventory_item_filter_tags' => :'inventoryItemFilterTags',
        :'option' => :'option',
        :'sequence' => :'sequence',
        :'finishing_operation' => :'finishingOperation',
        :'inventory_item' => :'inventoryItem',
        :'show_related_inventory_items' => :'showRelatedInventoryItems',
        :'ask_note' => :'askNote'
      }
    end
  end
end
