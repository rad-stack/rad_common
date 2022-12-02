module RadCommon
  module AttachmentsHelper
    def render_attachment_layout(attachment_name:, record:,
                                 override_label: nil, show_filename: nil, no_delete_button: nil)
      return unless record.persisted?

      attachment = record.send(attachment_name)
      return unless !attachment.respond_to?(:attached?) || attachment.attached?

      label_override = override_label.presence
      filename_label = show_filename ? " #{attachment.filename}" : nil
      no_delete = no_delete_button || !policy(record).update?

      render 'layouts/attachment_object', label_override: label_override,
                                          filename_label: filename_label, no_delete: no_delete
    end

    def render_attachments(attachment_name:, record:,
                           override_label: nil, show_filename: nil, no_delete_button: nil)
      return unless record.persisted?

      attachments = record.send(attachment_name)
      return if attachments.blank?

      record.send(attachment_name).each do |attachment|
        render 'layouts/attachment_object', attachment: attachment, record: record,
                                            override_label: override_label, show_filename: show_filename,
                                            no_delete_button: no_delete_button
      end
    end
  end
end
