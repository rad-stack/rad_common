class ContactLogRecipientsController < ApplicationController
  before_action :set_contact_log_recipient, only: :show

  def show
    redirect_to @contact_log_recipient.contact_log
  end

  private

    def set_contact_log_recipient
      @contact_log_recipient = ContactLogRecipient.find(params[:id])
      authorize @contact_log_recipient
    end
end
