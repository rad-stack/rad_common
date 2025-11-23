class FixContactLogSMSStatus < ActiveRecord::Migration[7.0]
  def change
    # return if ContactLogRecipient.none?
    #
    # ContactLogRecipient.joins(:contact_log)
    #                    .where('sms_status IS NOT NULL AND contact_logs.service_type = 0 AND sms_log_type = 1')
    #                    .update_all(sms_status: nil)
  end
end
