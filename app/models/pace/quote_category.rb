module Pace
  class QuoteCategory < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :department

    attr_accessor :default_open

    attr_accessor :quick_copy_option

    attr_accessor :print_options

    attr_accessor :quote_category_group

    attr_accessor :usage_hint

    attr_accessor :allow_multiselect_in_option_view


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'department' => :'department',
        :'default_open' => :'defaultOpen',
        :'quick_copy_option' => :'quickCopyOption',
        :'print_options' => :'printOptions',
        :'quote_category_group' => :'quoteCategoryGroup',
        :'usage_hint' => :'usageHint',
        :'allow_multiselect_in_option_view' => :'allowMultiselectInOptionView'
      }
    end
  end
end
