module Pace
  class QueuedNotification < Base
    attr_accessor :id

    attr_accessor :headers

    attr_accessor :content_type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :notification_key

    attr_accessor :notifier_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'headers' => :'headers',
        :'content_type' => :'contentType',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'notification_key' => :'notificationKey',
        :'notifier_id' => :'notifierId'
      }
    end
  end
end
