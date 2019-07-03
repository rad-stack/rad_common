module ActiveStorageDownloader
  include ActiveStorage::Downloading
  extend ActiveSupport::Concern

  attr_reader :blob

  def serve_active_storage_file(attachment, filename)
    @blob = attachment.blob
    download_and_serve_file(attachment.blob.filename.extension_with_delimiter, attachment.blob.content_type, filename)
  end

  def download_and_serve_file(ext, content_type, filename)
    download_blob_to_tempfile do |file|
      send_data file.read, filename: "#{filename}.#{ext}", type: content_type, disposition: 'inline'
    end
  end
end
