module Pace
  class PaceConnectEvent < Base
    attr_accessor :id

    attr_accessor :completed

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect

    attr_accessor :created_date

    attr_accessor :created_by

    attr_accessor :related_object_id

    attr_accessor :related_object

    attr_accessor :source_object

    attr_accessor :source_object_id

    attr_accessor :event_handler_event_type

    attr_accessor :created_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'completed' => :'completed',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect' => :'paceConnect',
        :'created_date' => :'createdDate',
        :'created_by' => :'createdBy',
        :'related_object_id' => :'relatedObjectId',
        :'related_object' => :'relatedObject',
        :'source_object' => :'sourceObject',
        :'source_object_id' => :'sourceObjectId',
        :'event_handler_event_type' => :'eventHandlerEventType',
        :'created_time' => :'createdTime'
      }
    end
  end
end
