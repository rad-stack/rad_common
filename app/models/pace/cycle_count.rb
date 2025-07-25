module Pace
  class CycleCount < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :scope

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :display_all_quantities

    attr_accessor :count_frequency

    attr_accessor :completed_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'scope' => :'scope',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'display_all_quantities' => :'displayAllQuantities',
        :'count_frequency' => :'countFrequency',
        :'completed_date' => :'completedDate'
      }
    end
  end
end
