module RadCommon
  class ContentTypeIcon
    attr_accessor :content_type

    alias_attribute :to_s, :icon

    def initialize(content_type)
      self.content_type = content_type
    end

    def icon
      types = {
        'application/msword' => 'fa-file-word',
        'application/pdf' => 'fa-file-pdf',
        'application/vnd.ms-excel.sheet.macroenabled.12' => 'fa-file-excel',
        'application/vnd.ms-excel' => 'fa-file-excel',
        'application/vnd.openxmlformats-officedocument.presentationml.presentation' => 'fa-tv',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => 'fa-table',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'fa-file-lines',
        'application/zip' => 'fa-file-zipper',
        'text/csv' => 'fa-table',
        'text/html' => 'fa-code',
        'text/plain' => 'fa-file',
        'video/quicktime' => 'fa-file-video'
      }

      types[content_type].presence || 'fa-paperclip'
    end
  end
end
