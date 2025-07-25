module Pace
  class QuoteLetterType < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :comment

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :body

    attr_accessor :use_alternate_text

    attr_accessor :salutation

    attr_accessor :print_price_grid

    attr_accessor :include_flat_size

    attr_accessor :include_item_description

    attr_accessor :include_ink_type

    attr_accessor :include_item_extended_price

    attr_accessor :append_certification_level

    attr_accessor :include_item_uom

    attr_accessor :include_quantities

    attr_accessor :include_final_size

    attr_accessor :include_price_per_addl_m

    attr_accessor :price_detail_level

    attr_accessor :include_price_per_m

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

    attr_accessor :include_item_totals

    attr_accessor :include_part_descriptions

    attr_accessor :include_quantity_descriptions

    attr_accessor :include_tax

    attr_accessor :include_quantity

    attr_accessor :closing

    attr_accessor :use_standard_space_font

    attr_accessor :disclaimer

    attr_accessor :extended_price_label

    attr_accessor :paper_sequence

    attr_accessor :size_sequence

    attr_accessor :usage

    attr_accessor :press_label

    attr_accessor :per_m_label

    attr_accessor :pages_sequence

    attr_accessor :item_sequence

    attr_accessor :standard_label

    attr_accessor :quote_tax

    attr_accessor :bleeds_label

    attr_accessor :product_label

    attr_accessor :total_colors_label

    attr_accessor :print_prepress

    attr_accessor :sides_label

    attr_accessor :pricing_uom_label

    attr_accessor :per_addl_m_label

    attr_accessor :include_description

    attr_accessor :print_finishing

    attr_accessor :print_salesperson

    attr_accessor :print_estimator

    attr_accessor :pgs_label

    attr_accessor :per_addl100_label

    attr_accessor :qty_label

    attr_accessor :shipping_sequence

    attr_accessor :qty_message_label

    attr_accessor :per_square_unit_label

    attr_accessor :unit_price_label

    attr_accessor :one_side_label

    attr_accessor :side_label

    attr_accessor :each_of_label

    attr_accessor :per_addl_each_label

    attr_accessor :tax_label

    attr_accessor :bleed_label

    attr_accessor :prepress_label

    attr_accessor :description_sequence

    attr_accessor :process_label

    attr_accessor :print_provided

    attr_accessor :quote_letter_notes_header

    attr_accessor :print_pages

    attr_accessor :description_label

    attr_accessor :black_label

    attr_accessor :print_ink

    attr_accessor :paper_label

    attr_accessor :ink_sequence

    attr_accessor :pages_label

    attr_accessor :category_label

    attr_accessor :press_sequence

    attr_accessor :provided_sequence

    attr_accessor :disc_label

    attr_accessor :final_size_label

    attr_accessor :est_tax_matls_label

    attr_accessor :ink_label

    attr_accessor :buy_out_label

    attr_accessor :print_shipping

    attr_accessor :prices_label

    attr_accessor :per_each_label

    attr_accessor :price_label

    attr_accessor :provided_label

    attr_accessor :print_signature_lines

    attr_accessor :tax_detail_sequence

    attr_accessor :populate_notes

    attr_accessor :page_cover_label

    attr_accessor :desc_label

    attr_accessor :finishing_sequence

    attr_accessor :shipping_label

    attr_accessor :per100_label

    attr_accessor :print_size

    attr_accessor :qty_description_label

    attr_accessor :finishing_label

    attr_accessor :print_paper

    attr_accessor :print_item_on_separate_lines

    attr_accessor :uom_label

    attr_accessor :pmslabel

    attr_accessor :print_company_info

    attr_accessor :print_item

    attr_accessor :print_tax_details

    attr_accessor :consolidate_component_type

    attr_accessor :consolidate_estimate_parts

    attr_accessor :print_buy_out

    attr_accessor :price_sequence

    attr_accessor :total_price_label

    attr_accessor :tax_exempt_label

    attr_accessor :part_label

    attr_accessor :est_tax_base_label

    attr_accessor :prepress_sequence

    attr_accessor :print_company_name

    attr_accessor :note_grouping

    attr_accessor :print_press

    attr_accessor :print_description

    attr_accessor :per_label

    attr_accessor :item_label

    attr_accessor :print_price

    attr_accessor :total_label

    attr_accessor :flat_size_label

    attr_accessor :size_label

    attr_accessor :tax_detail_label

    attr_accessor :buy_out_sequence


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'comment' => :'comment',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'body' => :'body',
        :'use_alternate_text' => :'useAlternateText',
        :'salutation' => :'salutation',
        :'print_price_grid' => :'printPriceGrid',
        :'include_flat_size' => :'includeFlatSize',
        :'include_item_description' => :'includeItemDescription',
        :'include_ink_type' => :'includeInkType',
        :'include_item_extended_price' => :'includeItemExtendedPrice',
        :'append_certification_level' => :'appendCertificationLevel',
        :'include_item_uom' => :'includeItemUOM',
        :'include_quantities' => :'includeQuantities',
        :'include_final_size' => :'includeFinalSize',
        :'include_price_per_addl_m' => :'includePricePerAddlM',
        :'price_detail_level' => :'priceDetailLevel',
        :'include_price_per_m' => :'includePricePerM',
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
        :'include_item_totals' => :'includeItemTotals',
        :'include_part_descriptions' => :'includePartDescriptions',
        :'include_quantity_descriptions' => :'includeQuantityDescriptions',
        :'include_tax' => :'includeTax',
        :'include_quantity' => :'includeQuantity',
        :'closing' => :'closing',
        :'use_standard_space_font' => :'useStandardSpaceFont',
        :'disclaimer' => :'disclaimer',
        :'extended_price_label' => :'extendedPriceLabel',
        :'paper_sequence' => :'paperSequence',
        :'size_sequence' => :'sizeSequence',
        :'usage' => :'usage',
        :'press_label' => :'pressLabel',
        :'per_m_label' => :'perMLabel',
        :'pages_sequence' => :'pagesSequence',
        :'item_sequence' => :'itemSequence',
        :'standard_label' => :'standardLabel',
        :'quote_tax' => :'quoteTax',
        :'bleeds_label' => :'bleedsLabel',
        :'product_label' => :'productLabel',
        :'total_colors_label' => :'totalColorsLabel',
        :'print_prepress' => :'printPrepress',
        :'sides_label' => :'sidesLabel',
        :'pricing_uom_label' => :'pricingUOMLabel',
        :'per_addl_m_label' => :'perAddlMLabel',
        :'include_description' => :'includeDescription',
        :'print_finishing' => :'printFinishing',
        :'print_salesperson' => :'printSalesperson',
        :'print_estimator' => :'printEstimator',
        :'pgs_label' => :'pgsLabel',
        :'per_addl100_label' => :'perAddl100Label',
        :'qty_label' => :'qtyLabel',
        :'shipping_sequence' => :'shippingSequence',
        :'qty_message_label' => :'qtyMessageLabel',
        :'per_square_unit_label' => :'perSquareUnitLabel',
        :'unit_price_label' => :'unitPriceLabel',
        :'one_side_label' => :'oneSideLabel',
        :'side_label' => :'sideLabel',
        :'each_of_label' => :'eachOfLabel',
        :'per_addl_each_label' => :'perAddlEachLabel',
        :'tax_label' => :'taxLabel',
        :'bleed_label' => :'bleedLabel',
        :'prepress_label' => :'prepressLabel',
        :'description_sequence' => :'descriptionSequence',
        :'process_label' => :'processLabel',
        :'print_provided' => :'printProvided',
        :'quote_letter_notes_header' => :'quoteLetterNotesHeader',
        :'print_pages' => :'printPages',
        :'description_label' => :'descriptionLabel',
        :'black_label' => :'blackLabel',
        :'print_ink' => :'printInk',
        :'paper_label' => :'paperLabel',
        :'ink_sequence' => :'inkSequence',
        :'pages_label' => :'pagesLabel',
        :'category_label' => :'categoryLabel',
        :'press_sequence' => :'pressSequence',
        :'provided_sequence' => :'providedSequence',
        :'disc_label' => :'discLabel',
        :'final_size_label' => :'finalSizeLabel',
        :'est_tax_matls_label' => :'estTaxMatlsLabel',
        :'ink_label' => :'inkLabel',
        :'buy_out_label' => :'buyOutLabel',
        :'print_shipping' => :'printShipping',
        :'prices_label' => :'pricesLabel',
        :'per_each_label' => :'perEachLabel',
        :'price_label' => :'priceLabel',
        :'provided_label' => :'providedLabel',
        :'print_signature_lines' => :'printSignatureLines',
        :'tax_detail_sequence' => :'taxDetailSequence',
        :'populate_notes' => :'populateNotes',
        :'page_cover_label' => :'pageCoverLabel',
        :'desc_label' => :'descLabel',
        :'finishing_sequence' => :'finishingSequence',
        :'shipping_label' => :'shippingLabel',
        :'per100_label' => :'per100Label',
        :'print_size' => :'printSize',
        :'qty_description_label' => :'qtyDescriptionLabel',
        :'finishing_label' => :'finishingLabel',
        :'print_paper' => :'printPaper',
        :'print_item_on_separate_lines' => :'printItemOnSeparateLines',
        :'uom_label' => :'uomLabel',
        :'pmslabel' => :'pmslabel',
        :'print_company_info' => :'printCompanyInfo',
        :'print_item' => :'printItem',
        :'print_tax_details' => :'printTaxDetails',
        :'consolidate_component_type' => :'consolidateComponentType',
        :'consolidate_estimate_parts' => :'consolidateEstimateParts',
        :'print_buy_out' => :'printBuyOut',
        :'price_sequence' => :'priceSequence',
        :'total_price_label' => :'totalPriceLabel',
        :'tax_exempt_label' => :'taxExemptLabel',
        :'part_label' => :'partLabel',
        :'est_tax_base_label' => :'estTaxBaseLabel',
        :'prepress_sequence' => :'prepressSequence',
        :'print_company_name' => :'printCompanyName',
        :'note_grouping' => :'noteGrouping',
        :'print_press' => :'printPress',
        :'print_description' => :'printDescription',
        :'per_label' => :'perLabel',
        :'item_label' => :'itemLabel',
        :'print_price' => :'printPrice',
        :'total_label' => :'totalLabel',
        :'flat_size_label' => :'flatSizeLabel',
        :'size_label' => :'sizeLabel',
        :'tax_detail_label' => :'taxDetailLabel',
        :'buy_out_sequence' => :'buyOutSequence'
      }
    end
  end
end
