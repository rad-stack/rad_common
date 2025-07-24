module Pace
  class QuoteLetterNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :note

    attr_accessor :quote_letter

    attr_accessor :print_on_report

    attr_accessor :print_sequence


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'note' => :'note',
        :'quote_letter' => :'quoteLetter',
        :'print_on_report' => :'printOnReport',
        :'print_sequence' => :'printSequence'
      }
    end
  end
end
