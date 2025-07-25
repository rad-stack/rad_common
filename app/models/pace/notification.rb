module Pace
  class Notification < Base
    attr_accessor :message

    attr_accessor :id

    attr_accessor :active

    attr_accessor :url

    attr_accessor :title

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :entered_by

    attr_accessor :start_date

    attr_accessor :send_to_all

    attr_accessor :requires_acknowledgment

    attr_accessor :expiration_date

    attr_accessor :date_time

    attr_accessor :remote_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'message' => :'message',
        :'id' => :'id',
        :'active' => :'active',
        :'url' => :'url',
        :'title' => :'title',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'entered_by' => :'enteredBy',
        :'start_date' => :'startDate',
        :'send_to_all' => :'sendToAll',
        :'requires_acknowledgment' => :'requiresAcknowledgment',
        :'expiration_date' => :'expirationDate',
        :'date_time' => :'dateTime',
        :'remote_id' => :'remoteId'
      }
    end
  end
end
