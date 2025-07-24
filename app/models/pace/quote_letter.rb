module Pace
  class QuoteLetter < Base
    attr_accessor :id

    attr_accessor :comment

    attr_accessor :date

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :body

    attr_accessor :salutation

    attr_accessor :quote

    attr_accessor :quote_quantity

    attr_accessor :quote_letter_type

    attr_accessor :closing


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'comment' => :'comment',
        :'date' => :'date',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'body' => :'body',
        :'salutation' => :'salutation',
        :'quote' => :'quote',
        :'quote_quantity' => :'quoteQuantity',
        :'quote_letter_type' => :'quoteLetterType',
        :'closing' => :'closing'
      }
    end
  end
end
