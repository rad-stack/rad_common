module Pace
  class Attachment < Base
    attr_accessor :mime_type

    attr_accessor :name

    attr_accessor :file_extension

    attr_accessor :content


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'mime_type' => :'mimeType',
        :'name' => :'name',
        :'file_extension' => :'fileExtension',
        :'content' => :'content'
      }
    end
  end
end
