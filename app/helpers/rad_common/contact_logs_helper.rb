module RadCommon
  module ContactLogsHelper
    def contact_log_show_data(contact_log)
      items = [:service_type,
               :sms_log_type,
               :from_number,
               :from_email,
               { label: 'From User', value: secured_link(contact_log.from_user) },
               { label: contact_log.record.present? ? contact_log.record_type.titleize : 'Record',
                 value: secured_link(contact_log.record) },
               :content,
               :sent]

      items += %i[sms_opt_out_message_sent] if contact_log.sms?
      items + %i[sms_message_id sms_media_url]
    end

    def contact_log_recipient_show_data(contact_log_recipient)
      [{ label: 'To User', value: secured_link(contact_log_recipient.to_user) },
       :email,
       :email_type,
       :email_status,
       :sendgrid_reason,
       :phone_number,
       :sms_status,
       :notify_on_fail,
       :success]
    end
  end
end
