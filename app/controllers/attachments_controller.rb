class DownloadAttachmentsController < ApplicationController
  include ActiveStorageDownloader
  before_action :set_record

  def download
    variant = params[:variant]
    serve_active_storage_file(@record.send(variant), variant)
  end

  def auditing_security?
    false
  end

  private

    def set_record
      klass = params[:class].constantize
      @record = klass.find_decoded(params[:attachment_id])
    end
end
