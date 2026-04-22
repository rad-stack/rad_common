module ActiveStorageDownloader
  extend ActiveSupport::Concern

  attr_reader :blob

  private

    def serve_active_storage_file(attachment, filename, cached: false)
      # TODO: refactor this to use single method for production and development, may need to wait until Rails 6
      if Rails.env.production? || Rails.env.staging?
        serve_file attachment.url,
                   attachment.blob.filename.extension_with_delimiter,
                   attachment.blob.content_type,
                   filename,
                   cached: cached
      else
        @blob = attachment.blob
        download_and_serve_file attachment.blob.filename.extension_with_delimiter,
                                attachment.blob.content_type,
                                filename
      end
    end

    def download_and_serve_file(ext, content_type, filename)
      # does not support variants/resizing
      @blob.open do |file|
        send_data file.read, filename: "#{filename}.#{ext}", type: content_type, disposition: 'inline'
      end
    end

    def serve_file(url, ext, content_type, filename, cached: false)
      # crashes locally, only use for production
      data = RadRetry.perform_request(retry_count: 2) { URI.parse(url).open }
      file_content = data.read

      if cached
        cache_time = 1.week.to_i
        response.headers['Cache-Control'] = "public, max-age=#{cache_time}"
        response.headers['ETag'] = Digest::MD5.hexdigest(file_content)
      end

      send_data file_content, filename: "#{filename}.#{ext}", type: content_type, disposition: 'inline'
    end
end
