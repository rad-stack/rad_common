module RadCommon
  module AttachmentsHelper
    def render_one_attachment(attachment_name:, record:, override_label: nil, show_filename: nil, no_delete_button: nil, override_path: nil, new_tab: nil)
      return unless record.persisted?

      attachment = record.send(attachment_name)
      return unless !attachment.respond_to?(:attached?) || attachment.attached?

      AttachmentRenderer.new(current_user, self).render_attachment_object attachment: attachment, record: record, override_label: override_label, show_filename: show_filename, no_delete_button: no_delete_button, override_path: override_path, new_tab: new_tab
    end

    def render_many_attachments(attachment_name:, record:, override_label: nil, show_filename: nil, no_delete_button: nil, override_path: nil, new_tab: nil)
      return unless record.persisted?

      attachments = record.send(attachment_name)
      return if attachments.blank?

      safe_join(record.send(attachment_name).map do |attachment|
        AttachmentRenderer.new(current_user, self).render_attachment_object attachment: attachment, record: record, override_label: override_label, show_filename: show_filename, no_delete_button: no_delete_button, override_path: override_path, new_tab: new_tab
      end)
    end
  end
end
