class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  authority_actions destroy: 'update'

  def destroy
    attachment = ActiveStorage::Attachment.find(params[:id])
    record = attachment.record
    authorize_action_for record
    attachment.purge_later
    flash[:success] = 'Attachment successfully deleted'
    redirect_back(fallback_location: record)
  end
end
