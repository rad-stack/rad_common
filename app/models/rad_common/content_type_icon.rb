module RadCommon
  class ContentTypeIcon
    attr_accessor :content_type

    alias_attribute :to_s, :icon

    def initialize(content_type)
      self.content_type = content_type
    end

    def icon
      types = {
        'application/msword' => 'fa-file-word-o',
        'application/pdf' => 'fa-file-pdf-o',
        'application/vnd.ms-excel.sheet.macroenabled.12' => 'fa-file-excel-o',
        'application/vnd.openxmlformats-officedocument.presentationml.presentation' => 'fa-tv',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => 'fa-table',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'fa-file-text-o',
        'application/zip' => 'fa-file-archive-o',
        'text/csv' => 'fa-table',
        'text/html' => 'fa-code',
        'text/plain' => 'fa-file-o',
        'video/quicktime' => 'fa-file-video-o'
      }

      types[content_type].presence || 'fa-paperclip'
    end
  end
end
