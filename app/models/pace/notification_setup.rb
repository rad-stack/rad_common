module Pace
  class NotificationSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :push_notification_on_multiple_updates

    attr_accessor :max_text_message_size

    attr_accessor :idle_time_out

    attr_accessor :push_system_notification

    attr_accessor :input_buffer_size

    attr_accessor :max_binary_message_size


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'push_notification_on_multiple_updates' => :'pushNotificationOnMultipleUpdates',
        :'max_text_message_size' => :'maxTextMessageSize',
        :'idle_time_out' => :'idleTimeOut',
        :'push_system_notification' => :'pushSystemNotification',
        :'input_buffer_size' => :'inputBufferSize',
        :'max_binary_message_size' => :'maxBinaryMessageSize'
      }
    end
  end
end
