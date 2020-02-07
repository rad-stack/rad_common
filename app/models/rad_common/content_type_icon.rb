module RadCommon
  class ContentTypeIcon
    attr_accessor :content_type
    alias_attribute :to_s, :icon

    def initialize(content_type)
      self.content_type = content_type
    end

    def icon
      case content_type
      when 'application/msword'
        'fa-file-word-o'
      when 'application/pdf'
        'fa-file-pdf-o'
      when 'application/vnd.ms-excel.sheet.macroenabled.12'
        'fa-file-excel-o'
      when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
        'fa-tv'
      when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        'fa-table'
      when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        'fa-file-text-o'
      when 'application/zip'
        'fa-file-archive-o'
      when 'text/csv'
        'fa-table'
      when 'text/html'
        'fa-code'
      when 'text/plain'
        'fa-file-o'
      when 'video/quicktime'
        'fa-file-video-o'
      else
        'fa-paperclip'
      end
    end
  end
end
