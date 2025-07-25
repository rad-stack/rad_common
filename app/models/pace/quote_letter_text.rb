module Pace
  class QuoteLetterText < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :note


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'sequence' => :'sequence',
        :'note' => :'note'
      }
    end
  end
end
