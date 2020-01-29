module RadCommon
  class AttachmentsController < ApplicationController
    require 'open-uri'

    include ActiveStorageDownloader

    before_action :authenticate_user!, only: :destroy
    before_action :set_variant, only: :download_variant

    def download
      skip_authorization

      # TODO: refactor this with Hashable
      ids = Hashable.hashids.decode(params[:id])
      attachment_id = ids[0]
      #

      attachment = ActiveStorage::Attachment.find_by(id: attachment_id)

      if attachment.present?
        serve_active_storage_file(attachment, attachment.name)
      else
        render json: 'Attachment not found'
      end
    end

    def download_variant
      skip_authorization

      if @variant.present?
        serve_active_storage_file(@variant, params[:variant])
      else
        render json: 'Attachment not found'
      end
    end

    def destroy
      attachment = ActiveStorage::Attachment.find(params[:id])
      record = attachment.record
      authorize record, :update?
      attachment.send(:audit_destroy)
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
  end
end
