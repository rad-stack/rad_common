module RadCommon
  module ContactLogsHelper
    def contact_log_show_data(contact_log)
      # TODO: hide sms fields when not applicable
      # TODO: test each item here to see how it's displayed
      [:service_type,
       :sms_log_type,
       :created_at,
       :from_number,
       :from_email,
       { label: 'From User', value: secured_link(contact_log.from_user) },
       { label: 'Record', value: secured_link(contact_log.record) },
       :content,
       :sms_opt_out_message_sent,
       :sms_sent,
       :sms_message_id,
       :sms_media_url]
    end
  end
end
