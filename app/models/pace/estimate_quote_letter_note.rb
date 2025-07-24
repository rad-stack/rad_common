module Pace
  class EstimateQuoteLetterNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :note

    attr_accessor :estimate_part

    attr_accessor :estimate_quantity

    attr_accessor :estimate_product

    attr_accessor :product

    attr_accessor :estimate

    attr_accessor :component_description

    attr_accessor :section

    attr_accessor :quote_letter_text

    attr_accessor :print_on_report

    attr_accessor :part

    attr_accessor :section_divider

    attr_accessor :use_standard_space_font

    attr_accessor :note_prefix

    attr_accessor :estimate_quote_letter


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'sequence' => :'sequence',
        :'note' => :'note',
        :'estimate_part' => :'estimatePart',
        :'estimate_quantity' => :'estimateQuantity',
        :'estimate_product' => :'estimateProduct',
        :'product' => :'product',
        :'estimate' => :'estimate',
        :'component_description' => :'componentDescription',
        :'section' => :'section',
        :'quote_letter_text' => :'quoteLetterText',
        :'print_on_report' => :'printOnReport',
        :'part' => :'part',
        :'section_divider' => :'sectionDivider',
        :'use_standard_space_font' => :'useStandardSpaceFont',
        :'note_prefix' => :'notePrefix',
        :'estimate_quote_letter' => :'estimateQuoteLetter'
      }
    end
  end
end
