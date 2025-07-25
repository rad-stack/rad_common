module Pace
  class ShipZonePostalCode < Base
    attr_accessor :id

    attr_accessor :zone

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :postal_code_from

    attr_accessor :postal_code_to


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'zone' => :'zone',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'postal_code_from' => :'postalCodeFrom',
        :'postal_code_to' => :'postalCodeTo'
      }
    end
  end
end
