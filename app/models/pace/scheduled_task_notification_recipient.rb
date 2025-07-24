module Pace
  class ScheduledTaskNotificationRecipient < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :scheduled_task

    attr_accessor :scheduled_task_output_location_key

    attr_accessor :recipient_type

    attr_accessor :scheduled_task_output_location

    attr_accessor :system_user

    attr_accessor :twitter_account

    attr_accessor :facebook_account

    attr_accessor :rss_channel

    attr_accessor :system_group


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'scheduled_task' => :'scheduledTask',
        :'scheduled_task_output_location_key' => :'scheduledTaskOutputLocationKey',
        :'recipient_type' => :'recipientType',
        :'scheduled_task_output_location' => :'scheduledTaskOutputLocation',
        :'system_user' => :'systemUser',
        :'twitter_account' => :'twitterAccount',
        :'facebook_account' => :'facebookAccount',
        :'rss_channel' => :'rssChannel',
        :'system_group' => :'systemGroup'
      }
    end
  end
end
