module Pace
  class QuoteProductContentFile < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :production

    attr_accessor :content_file

    attr_accessor :sequence

    attr_accessor :quote_product


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'production' => :'production',
        :'content_file' => :'contentFile',
        :'sequence' => :'sequence',
        :'quote_product' => :'quoteProduct'
      }
    end
  end
end
