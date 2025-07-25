module Pace
  class QuoteLetterTypeText < Base
    attr_accessor :id

    attr_accessor :object

    attr_accessor :print

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :note_category

    attr_accessor :line_type

    attr_accessor :print_price_grid

    attr_accessor :include_flat_size

    attr_accessor :include_item_description

    attr_accessor :include_ink_type

    attr_accessor :include_item_extended_price

    attr_accessor :append_certification_level

    attr_accessor :include_item_uom

    attr_accessor :include_price_per100

    attr_accessor :include_price_per_addl100

    attr_accessor :include_price_per_uom

    attr_accessor :include_quantities

    attr_accessor :include_final_size

    attr_accessor :section

    attr_accessor :include_price_per_addl_m

    attr_accessor :price_detail_level

    attr_accessor :include_descriptions

    attr_accessor :include_price_per_m

    attr_accessor :xpath

    attr_accessor :include_item_category

    attr_accessor :include_item_unit_price

    attr_accessor :include_price_per_addl_each

    attr_accessor :each_of_display

    attr_accessor :include_item_quantity

    attr_accessor :include_sizes

    attr_accessor :include_total_price

    attr_accessor :include_price_per_square_unit

    attr_accessor :include_price_per_each

    attr_accessor :include_quoted_price

    attr_accessor :text_position

    attr_accessor :include_item_totals

    attr_accessor :quote_letter_type

    attr_accessor :include_part_descriptions

    attr_accessor :include_quantity_descriptions

    attr_accessor :include_tax

    attr_accessor :include_quantity

    attr_accessor :print_on_separate_lines

    attr_accessor :quote_letter_text


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'object' => :'object',
        :'print' => :'print',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'sequence' => :'sequence',
        :'note_category' => :'noteCategory',
        :'line_type' => :'lineType',
        :'print_price_grid' => :'printPriceGrid',
        :'include_flat_size' => :'includeFlatSize',
        :'include_item_description' => :'includeItemDescription',
        :'include_ink_type' => :'includeInkType',
        :'include_item_extended_price' => :'includeItemExtendedPrice',
        :'append_certification_level' => :'appendCertificationLevel',
        :'include_item_uom' => :'includeItemUOM',
        :'include_price_per100' => :'includePricePer100',
        :'include_price_per_addl100' => :'includePricePerAddl100',
        :'include_price_per_uom' => :'includePricePerUOM',
        :'include_quantities' => :'includeQuantities',
        :'include_final_size' => :'includeFinalSize',
        :'section' => :'section',
        :'include_price_per_addl_m' => :'includePricePerAddlM',
        :'price_detail_level' => :'priceDetailLevel',
        :'include_descriptions' => :'includeDescriptions',
        :'include_price_per_m' => :'includePricePerM',
        :'xpath' => :'xpath',
        :'include_item_category' => :'includeItemCategory',
        :'include_item_unit_price' => :'includeItemUnitPrice',
        :'include_price_per_addl_each' => :'includePricePerAddlEach',
        :'each_of_display' => :'eachOfDisplay',
        :'include_item_quantity' => :'includeItemQuantity',
        :'include_sizes' => :'includeSizes',
        :'include_total_price' => :'includeTotalPrice',
        :'include_price_per_square_unit' => :'includePricePerSquareUnit',
        :'include_price_per_each' => :'includePricePerEach',
        :'include_quoted_price' => :'includeQuotedPrice',
        :'text_position' => :'textPosition',
        :'include_item_totals' => :'includeItemTotals',
        :'quote_letter_type' => :'quoteLetterType',
        :'include_part_descriptions' => :'includePartDescriptions',
        :'include_quantity_descriptions' => :'includeQuantityDescriptions',
        :'include_tax' => :'includeTax',
        :'include_quantity' => :'includeQuantity',
        :'print_on_separate_lines' => :'printOnSeparateLines',
        :'quote_letter_text' => :'quoteLetterText'
      }
    end
  end
end
