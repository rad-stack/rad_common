module RadCommon
  module AttachmentsHelper
    def render_attachment_layout(attachment_name:, record:,
                                 override_label: nil, show_filename: nil, no_delete_button: nil,
                                 override_path: nil, new_tab: nil)
      return unless record.persisted?

      attachment = record.send(attachment_name)
      return unless !attachment.respond_to?(:attached?) || attachment.attached?

      render_attachment_object(attachment: attachment, record: record, override_label: override_label,
                               show_filename: show_filename, no_delete_button: no_delete_button,
                               override_path: override_path, new_tab: new_tab)
    end

    def render_attachment_object(attachment:, record:,
                                 override_label:, show_filename:, no_delete_button:, override_path:, new_tab:)
      label_override = override_label.presence
      filename_label = show_filename ? " #{attachment.filename}" : nil
      no_delete = no_delete_button || !policy(record).update?
      render 'layouts/attachment_object', attachment: attachment, label_override: label_override,
                                          filename_label: filename_label, no_delete: no_delete,
                                          override_path: override_path, new_tab: new_tab
    end

    def render_attachment_image(attachment:, override_path:, new_tab:, label_override:, no_delete:)
      link = (override_path.presence || url_for(attachment))
      target = new_tab ? '_blank' : nil

      attachment_label =
        label_override.presence || image_tag(attachment, class: 'img-fluid rounded', id: 'attachment_layout')

      [link_to(attachment_label, link, target: target, class: 'text-wrap'),
       render_delete_attachment_link(attachment: attachment, no_delete: no_delete)].join(' ').html_safe
    end

    def render_delete_attachment_link(attachment:, no_delete:)
      return if no_delete

      link_to tag.i('', class: 'fa fa-times'),
              RadCommon::Engine.routes.url_helpers.attachment_path(attachment.id),
              method: :delete,
              data: { confirm: 'Are you sure? Attachment cannot be recovered.' },
              class: 'btn btn-danger ml-5'
    end

    def render_attachment_link(attachment:, no_delete:, label_override:, filename_label:)
      default_label = tag.i('', class: "fa #{RadCommon::ContentTypeIcon.new(attachment.content_type)}") + filename_label
      attachment_label = label_override.presence || default_label
      [link_to(attachment_label,
               url_for(attachment),
               target: '_blank',
               rel: :noopener,
               class: 'btn btn-secondary attachment-link text-wrap'),
       render_delete_attachment_link(attachment: attachment, no_delete: no_delete)].join(' ').html_safe
    end

    def render_attachments_layout(attachment_name:, record:,
                                  override_label: nil, show_filename: nil, no_delete_button: nil,
                                  override_path: nil, new_tab: nil)
      return unless record.persisted?

      attachments = record.send(attachment_name)
      return if attachments.blank?

      record.send(attachment_name).map { |attachment|
        render_attachment_object(attachment: attachment, record: record, override_label: override_label,
                                 show_filename: show_filename, no_delete_button: no_delete_button,
                                 override_path: override_path, new_tab: new_tab)
      }.join(' ').html_safe
    end
  end
end
