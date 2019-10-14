module RadCommon
  class AttachmentsController < ApplicationController
    include ActiveStorage::Downloading

    before_action :authenticate_user!, only: :destroy
    before_action :set_variant, only: :download_variant

    attr_reader :blob

    authority_actions destroy: 'update'

    def download_variant
      if @variant.present?
        serve_active_storage_file(@variant, params[:variant])
      else
        render json: 'Attachment not found'
      end
    end

    def destroy
      attachment = ActiveStorage::Attachment.find(params[:id])
      record = attachment.record
      authorize_action_for record
      attachment.purge_later
      flash[:success] = 'Attachment successfully deleted'
      redirect_back(fallback_location: record)
    end

    def auditing_security?
      action_name == 'destroy'
    end

    private

      def set_variant
        klass = params[:class_name].classify.constantize
        record = klass.find_decoded(params[:id])
        begin
          @variant = record.send(params[:variant]).processed
        rescue NoMethodError
          @variant = nil
        end
      end

      def serve_active_storage_file(attachment, filename)
        # TODO: refactor this to use single method for production and development, may need to wait until Rails 6
        if Rails.env.production?
          serve_file(attachment.service_url, attachment.blob.filename.extension_with_delimiter, attachment.blob.content_type, filename)
        else
          @blob = attachment.blob
          download_and_serve_file(attachment.blob.filename.extension_with_delimiter, attachment.blob.content_type, filename)
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
end
