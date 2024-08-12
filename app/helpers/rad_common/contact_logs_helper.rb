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
       :notified_on_failure?,
       :success]
    end

    def email_alert_input_label(record, attribute)
      string_label, content = email_alert_content(record, attribute)
      return string_label unless content

      tag.label do
        safe_join(["#{string_label} ", content])
      end
    end

    def email_show_item(record, attribute)
      string_label, content = email_alert_content(record, attribute)
      value = record.send(attribute)

      { label: string_label, value: content ? safe_join([value, ' ', content]) : value }
    end

    def email_alert_content(record, attribute)
      string_label = translated_attribute_label(record, attribute)
      items = ContactLogRecipient.where(email: record.send(attribute)).sorted.limit(1)
      return [string_label, nil] if items.none?

      contact_log_recipient = items.first
      return [string_label, nil] if contact_log_recipient.success?

      contact_log = contact_log_recipient.contact_log
      alert_tag = tag.span(class: 'badge badge-danger') { 'Outgoing Email Failed' }
      content = policy(contact_log).show? ? link_to(alert_tag, contact_log) : alert_tag

      [string_label, content]
    end
  end
end
