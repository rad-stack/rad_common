module Pace
  class RushCharge < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :amount

    attr_accessor :percent_up_charge

    attr_accessor :production_days


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'amount' => :'amount',
        :'percent_up_charge' => :'percentUpCharge',
        :'production_days' => :'productionDays'
      }
    end
  end
end
