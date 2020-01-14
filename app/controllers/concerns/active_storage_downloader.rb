module ActiveStorageDownloader
  extend ActiveSupport::Concern
  include ActiveStorage::Downloading

  attr_reader :blob

  private

    def serve_active_storage_file(attachment, filename)
      # TODO: refactor this to use single method for production and development, may need to wait until Rails 6
      if Rails.env.production?
        serve_file attachment.service_url,
                   attachment.blob.filename.extension_with_delimiter,
                   attachment.blob.content_type,
                   filename
      else
        @blob = attachment.blob
        download_and_serve_file attachment.blob.filename.extension_with_delimiter,
                                attachment.blob.content_type,
                                filename
      end
    end

    def download_and_serve_file(ext, content_type, filename)
      # does not support variants/resizing
      download_blob_to_tempfile do |file|
        send_data file.read, filename: "#{filename}.#{ext}", type: content_type, disposition: 'inline'
      end
    end

    def serve_file(url, ext, content_type, filename)
      # crashes locally, only use for production
      data = URI.open(url)
      send_data data.read, filename: "#{filename}.#{ext}", type: content_type, disposition: 'inline'
    end
end
