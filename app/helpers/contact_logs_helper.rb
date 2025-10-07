module ContactLogsHelper
  def contact_log_show_data(contact_log)
    items = [:service_type,
             :direction,
             :from_number,
             :from_email,
             { label: 'From User', value: secured_link(contact_log.from_user) },
             { label: contact_log.record.present? ? contact_log.record_type.titleize : 'Record',
               value: secured_link(contact_log.record) },
             :content,
             :sent]

    items += %i[sms_opt_out_message_sent] if contact_log.sms?
    items += [:fax_message_id]
    items += [{ label: 'SMS Message ID', value: twilio_log_link(contact_log) }, :sms_media_url]

    # TODO: this was added for IJS but need to finish the feature for general use - Task 8671
    if contact_log.attachments.any?
      items.push(label: 'Attachments',
                 value: render_many_attachments(record: contact_log, attachment_name: 'attachments'))
    end

    items
  end

  def twilio_log_link(contact_log)
    return if contact_log.sms_message_id.blank?

    link_to contact_log.sms_message_id,
            "https://console.twilio.com/us1/monitor/logs/sms?pageSize=50&sid=#{contact_log.sms_message_id}",
            target: '_blank',
            rel: 'noopener'
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
     :sms_false_positive,
     :notified_on_failure?,
     :success]
  end

  def contact_alert_input_label(record, attribute, contact_attribute)
    string_label, content = contact_alert_content(record, attribute, contact_attribute)
    return string_label unless content

    tag.label do
      safe_join(["#{string_label} ", content])
    end
  end

  def contact_show_item(record, attribute, contact_attribute)
    string_label, content = contact_alert_content(record, attribute, contact_attribute)
    value = record.send(attribute)

    { label: string_label, value: content ? safe_join([value, ' ', content]) : value }
  end

  def contact_alert_content(record, attribute, contact_attribute)
    string_label = translated_attribute_label(record, attribute)
    items = ContactLogRecipient.where("#{contact_attribute} = ?", record.send(attribute)).sorted.limit(1)
    return [string_label, nil] if items.none?

    contact_log_recipient = items.first
    return [string_label, nil] if contact_log_recipient.success?

    contact_log = contact_log_recipient.contact_log
    alert_tag = tag.span(class: 'badge badge-danger') { 'Outgoing Contact Failed' }
    content = policy(contact_log).show? ? link_to(alert_tag, contact_log) : alert_tag

    [string_label, content]
  end
end
