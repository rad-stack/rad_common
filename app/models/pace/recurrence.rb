module Pace
  class Recurrence < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :active

    attr_accessor :day_of_month

    attr_accessor :hour

    attr_accessor :minute

    attr_accessor :day_of_week

    attr_accessor :month

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :scheduled_task

    attr_accessor :frequency


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'active' => :'active',
        :'day_of_month' => :'dayOfMonth',
        :'hour' => :'hour',
        :'minute' => :'minute',
        :'day_of_week' => :'dayOfWeek',
        :'month' => :'month',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'scheduled_task' => :'scheduledTask',
        :'frequency' => :'frequency'
      }
    end
  end
end
