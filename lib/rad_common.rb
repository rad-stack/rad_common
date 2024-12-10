require 'rad_common/engine'

module RadCommon
  VALID_IMAGE_TYPES = %w[image/png image/jpeg image/jpg image/webp].freeze

  VALID_VIDEO_TYPES = %w[video/x-msvideo video/mp4 video/mpeg video/3gpp video/quicktime].freeze

  VALID_AUDIO_TYPES = %w[audio/mpeg audio/mp3 audio/wav audio/wave audio/x-wav audio/aiff audio/x-aifc audio/x-aiff
                         audio/x-gsm audio/ulaw].freeze

  VALID_ATTACHMENT_TYPES = (%w[application/msword
                               application/pdf
                               application/vnd.ms-excel
                               application/vnd.ms-excel.sheet.macroenabled.12
                               application/vnd.ms-outlook
                               application/vnd.ms-powerpoint
                               application/vnd.openxmlformats-officedocument.presentationml.presentation
                               application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
                               application/vnd.openxmlformats-officedocument.wordprocessingml.document
                               application/x-iwork-pages-sffpages
                               application/x-ole-storage
                               application/x-secure-download
                               application/x-zip-compressed
                               application/zip
                               application/vnd.apple.pages
                               application/vnd.apple.keynote
                               application/vnd.apple.numbers
                               image/bmp
                               image/gif
                               image/vnd.adobe.photoshop
                               message/rfc822
                               text/csv
                               text/html
                               text/plain] + VALID_IMAGE_TYPES + VALID_VIDEO_TYPES + VALID_AUDIO_TYPES).freeze

  VALID_CONTENT_TYPE_MESSAGE = 'has an invalid content type of %<content_type>s, must be %<authorized_types>s'.freeze
  VALID_CONTENT_TYPE_MESSAGE_SHORT = 'has an invalid content type of %<content_type>s'.freeze
end
