module RadCommon
  module ContactLogsHelper
    def contact_log_show_data(contact_log)
      items = [:created_at,
               :service_type,
               :sms_log_type,
               :from_number,
               :from_email,
               { label: 'From User', value: secured_link(contact_log.from_user) },
               { label: 'Record', value: secured_link(contact_log.record) },
               :content,
               :sent]

      items += %i[sms_opt_out_message_sent] if contact_log.sms?
      items + %i[sms_message_id sms_media_url]
    end
  end
end
