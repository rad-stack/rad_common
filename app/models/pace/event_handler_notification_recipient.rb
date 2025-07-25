module Pace
  class EventHandlerNotificationRecipient < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :recipient_type

    attr_accessor :system_user

    attr_accessor :twitter_account

    attr_accessor :facebook_account

    attr_accessor :rss_channel

    attr_accessor :system_group

    attr_accessor :notification_consequence


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'recipient_type' => :'recipientType',
        :'system_user' => :'systemUser',
        :'twitter_account' => :'twitterAccount',
        :'facebook_account' => :'facebookAccount',
        :'rss_channel' => :'rssChannel',
        :'system_group' => :'systemGroup',
        :'notification_consequence' => :'notificationConsequence'
      }
    end
  end
end
