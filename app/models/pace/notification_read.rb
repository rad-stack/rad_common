module Pace
  class NotificationRead < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_user

    attr_accessor :notification

    attr_accessor :date_time_read


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_user' => :'systemUser',
        :'notification' => :'notification',
        :'date_time_read' => :'dateTimeRead'
      }
    end
  end
end
