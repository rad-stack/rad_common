module RadCommon
  class AttachmentsController < ApplicationController
    include ActiveStorageDownloader
    before_action :authenticate_user!, only: :destroy
    before_action :set_record, only: :download

    authority_actions destroy: 'update'

    def download
      attachment = params[:variant].present? ? @record.send(params[:variant]) : @attachment
      begin
        serve_active_storage_file(attachment, @attachment.filename.base)
      rescue NoMethodError
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

      def set_record
        @attachment = ActiveStorage::Attachment.find(Hashable.hashids.decode(params[:id])[0])
        @record = @attachment.record
      end
  end
end
