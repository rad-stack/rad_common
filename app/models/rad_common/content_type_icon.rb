module RadCommon
  class ContentTypeIcon
    attr_accessor :content_type

    alias_attribute :to_s, :icon

    def initialize(content_type)
      self.content_type = content_type
    end

    def icon
      if content_type.starts_with? 'image'
        'fa-file-image'
      elsif content_type.starts_with? 'video'
        'fa-file-video'
      elsif content_type.starts_with? 'audio'
        'fa-file-audio'
      else
        types = {
          'application/msword' => 'fa-file-word',
          'application/pdf' => 'fa-file-pdf',
          'application/vnd.ms-excel.sheet.macroenabled.12' => 'fa-file-excel',
          'application/vnd.ms-excel' => 'fa-file-excel',
          'application/vnd.openxmlformats-officedocument.presentationml.presentation' => 'fa-tv',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => 'fa-table',
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'fa-file-alt',
          'application/zip' => 'fa-file-archive',
          'text/csv' => 'fa-file-csv',
          'text/html' => 'fa-file-code',
          'text/plain' => 'fa-file-alt'
        }

        types[content_type].presence || 'fa-paperclip'
      end
    end
  end
end
