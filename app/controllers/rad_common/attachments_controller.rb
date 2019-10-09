module RadCommon
  class AttachmentsController < ApplicationController
    include ActiveStorageDownloader
    before_action :authenticate_user!, only: :destroy
    before_action :set_record, only: :download

    authority_actions destroy: 'update'

    def download
      variant = params[:variant]
      serve_active_storage_file(@record.send(variant), variant)
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
        klass = params[:class].constantize
        @record = klass.find_decoded(params[:id])
      end
  end
end
