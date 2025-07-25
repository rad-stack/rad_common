module Pace
  class ScheduledTaskResult < Base
    attr_accessor :message

    attr_accessor :id

    attr_accessor :type

    attr_accessor :execution_id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :scheduled_task

    attr_accessor :execution_end_date_time

    attr_accessor :execution_start_date_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'message' => :'message',
        :'id' => :'id',
        :'type' => :'type',
        :'execution_id' => :'executionId',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'scheduled_task' => :'scheduledTask',
        :'execution_end_date_time' => :'executionEndDateTime',
        :'execution_start_date_time' => :'executionStartDateTime'
      }
    end
  end
end
