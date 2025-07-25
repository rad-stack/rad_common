module Pace
  class FASetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :auto_process

    attr_accessor :gl_register_number_sequence

    attr_accessor :rounding

    attr_accessor :gl_posting_method


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'auto_process' => :'autoProcess',
        :'gl_register_number_sequence' => :'glRegisterNumberSequence',
        :'rounding' => :'rounding',
        :'gl_posting_method' => :'glPostingMethod'
      }
    end
  end
end
