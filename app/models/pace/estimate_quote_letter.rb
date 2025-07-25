module Pace
  class EstimateQuoteLetter < Base
    attr_accessor :id

    attr_accessor :comment

    attr_accessor :date

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :body

    attr_accessor :salutation

    attr_accessor :estimate

    attr_accessor :print_price_grid

    attr_accessor :price_detail_level

    attr_accessor :quote_letter_type

    attr_accessor :accepted

    attr_accessor :closing

    attr_accessor :internal_note


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
        :'estimate' => :'estimate',
        :'print_price_grid' => :'printPriceGrid',
        :'price_detail_level' => :'priceDetailLevel',
        :'quote_letter_type' => :'quoteLetterType',
        :'accepted' => :'accepted',
        :'closing' => :'closing',
        :'internal_note' => :'internalNote'
      }
    end
  end
end
