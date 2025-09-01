module AttachmentsHelper
  def render_one_attachment(attachment_name:, record:, override_label: nil, show_filename: nil,
                            no_delete_button: nil, override_path: nil, new_tab: nil)

    AttachmentRenderer.new(current_user,
                           self,
                           attachment_name: attachment_name,
                           record: record,
                           override_label: override_label,
                           show_filename: show_filename,
                           no_delete_button: no_delete_button,
                           override_path: override_path,
                           new_tab: new_tab).render_one
  end

  def render_many_attachments(attachment_name:, record:, override_label: nil, show_filename: nil,
                              no_delete_button: nil, override_path: nil, new_tab: nil)

    AttachmentRenderer.new(current_user,
                           self,
                           attachment_name: attachment_name,
                           record: record,
                           override_label: override_label,
                           show_filename: show_filename,
                           no_delete_button: no_delete_button,
                           override_path: override_path,
                           new_tab: new_tab).render_many
  end
end
