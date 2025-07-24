module Pace
  class PrintService < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :sequence

    attr_accessor :quantity_multiplier

    attr_accessor :fold_pattern_key

    attr_accessor :fold_pattern

    attr_accessor :pages

    attr_accessor :pattern_category

    attr_accessor :binding_side

    attr_accessor :record_type

    attr_accessor :create_press_form

    attr_accessor :use_price

    attr_accessor :determination_code

    attr_accessor :reviewed

    attr_accessor :dsf_media

    attr_accessor :media_size


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'sequence' => :'sequence',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'fold_pattern_key' => :'foldPatternKey',
        :'fold_pattern' => :'foldPattern',
        :'pages' => :'pages',
        :'pattern_category' => :'patternCategory',
        :'binding_side' => :'bindingSide',
        :'record_type' => :'recordType',
        :'create_press_form' => :'createPressForm',
        :'use_price' => :'usePrice',
        :'determination_code' => :'determinationCode',
        :'reviewed' => :'reviewed',
        :'dsf_media' => :'dsfMedia',
        :'media_size' => :'mediaSize'
      }
    end
  end
end
