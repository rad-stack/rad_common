module Pace
  class RelayDateTime < Base
    attr_accessor :id

    attr_accessor :day_of_week

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :metro_area_relay

    attr_accessor :pick_up_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'day_of_week' => :'dayOfWeek',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'metro_area_relay' => :'metroAreaRelay',
        :'pick_up_time' => :'pickUpTime'
      }
    end
  end
end
