module Pace
  class UOMSetup < Base
    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :display_prime_symbols

    attr_accessor :uom_setup_id

    attr_accessor :display_size_name

    attr_accessor :legacy_uom

    attr_accessor :length_by_width

    attr_accessor :length_by_width_separator

    attr_accessor :display_fractional_feet_as_inches


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'display_prime_symbols' => :'displayPrimeSymbols',
        :'uom_setup_id' => :'uomSetupID',
        :'display_size_name' => :'displaySizeName',
        :'legacy_uom' => :'legacyUOM',
        :'length_by_width' => :'lengthByWidth',
        :'length_by_width_separator' => :'lengthByWidthSeparator',
        :'display_fractional_feet_as_inches' => :'displayFractionalFeetAsInches'
      }
    end
  end
end
