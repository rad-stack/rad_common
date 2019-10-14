module RadCommon
  class AttachmentsController < ApplicationController
    include ActiveStorageDownloader
    before_action :authenticate_user!, only: :destroy
    before_action :set_variant, only: :download_variant

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
  end
end
