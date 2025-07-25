module Pace
  class UserDefinedObject < Base
    attr_accessor :data_object

    attr_accessor :parent_data_object

    attr_accessor :category

    attr_accessor :broadcast_events

    attr_accessor :supports_attachment

    attr_accessor :show_attachment_on_form

    attr_accessor :syncable


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'data_object' => :'dataObject',
        :'parent_data_object' => :'parentDataObject',
        :'category' => :'category',
        :'broadcast_events' => :'broadcastEvents',
        :'supports_attachment' => :'supportsAttachment',
        :'show_attachment_on_form' => :'showAttachmentOnForm',
        :'syncable' => :'syncable'
      }
    end
  end
end
