module Pace
  class EstimateQuoteLetterNotePrice < Base
    attr_accessor :id

    attr_accessor :column1

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_part

    attr_accessor :estimate_quantity

    attr_accessor :estimate_product

    attr_accessor :estimate

    attr_accessor :estimate_quote_letter_note

    attr_accessor :column10

    attr_accessor :column5

    attr_accessor :column4

    attr_accessor :column3

    attr_accessor :column2

    attr_accessor :column9

    attr_accessor :column8

    attr_accessor :column7

    attr_accessor :column6


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'column1' => :'column1',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_part' => :'estimatePart',
        :'estimate_quantity' => :'estimateQuantity',
        :'estimate_product' => :'estimateProduct',
        :'estimate' => :'estimate',
        :'estimate_quote_letter_note' => :'estimateQuoteLetterNote',
        :'column10' => :'column10',
        :'column5' => :'column5',
        :'column4' => :'column4',
        :'column3' => :'column3',
        :'column2' => :'column2',
        :'column9' => :'column9',
        :'column8' => :'column8',
        :'column7' => :'column7',
        :'column6' => :'column6'
      }
    end
  end
end
