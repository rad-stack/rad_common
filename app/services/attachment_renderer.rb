class AttachmentRenderer
  attr_reader :user, :context, :attachment_name, :record, :override_label, :show_filename, :no_delete_button,
              :override_path, :new_tab

  def initialize(user, context, attachment_name:, record:, override_label: nil, show_filename: nil,
                 no_delete_button: nil, override_path: nil, new_tab: nil)
    @user = user
    @context = context
    @attachment_name = attachment_name
    @record = record
    @override_label = override_label
    @show_filename = show_filename
    @no_delete_button = no_delete_button
    @override_path = override_path
    @new_tab = new_tab
  end

  def render_one
    return unless record.persisted?

    attachment = record.send(attachment_name)
    return unless !attachment.respond_to?(:attached?) || (attachment.attached? && attachment.persisted?)

    render_attachment_object attachment
  end

  def render_many
    return unless record.persisted?

    attachments = record.send(attachment_name)
    return if attachments.blank?

    context.safe_join(attachments.select(&:persisted?).map do |attachment|
      render_attachment_object attachment
    end)
  end

  private

    def render_attachment_object(attachment)
      label_override = override_label.presence
      filename_label = show_filename ? " #{attachment.filename}" : nil
      no_delete = no_delete_button || !Pundit.policy!(user, record).update?

      if attachment.content_type.include?('image')
        return context.content_tag(:div, class: 'attachment-wrapper') do
          render_attachment_image attachment: attachment,
                                  label_override: label_override,
                                  no_delete: no_delete
        end
      end

      context.content_tag(:div, class: 'attachment-wrapper') do
        context.content_tag(:div, class: 'attachment-button-box') do
          render_attachment_link attachment: attachment,
                                 label_override: label_override,
                                 no_delete: no_delete,
                                 filename_label: filename_label
        end
      end
    end

    def render_attachment_image(attachment:, label_override:, no_delete:)
      link = (override_path.presence || context.url_for(attachment))
      target = new_tab ? '_blank' : nil

      attachment_label = label_override.presence || context.image_tag(attachment,
                                                                      class: 'img-fluid rounded',
                                                                      id: 'attachment_layout')

      context.safe_join([context.link_to(attachment_label, link, target: target, class: 'text-wrap'),
                         render_delete_attachment_link(attachment: attachment, no_delete: no_delete)])
    end

    def render_delete_attachment_link(attachment:, no_delete:)
      return if no_delete

      context.link_to context.tag.i('', class: 'fa fa-times'),
                      context.attachment_path(attachment.id),
                      method: :delete,
                      data: { confirm: 'Are you sure? Attachment cannot be recovered.' },
                      class: 'btn btn-danger ml-5'
    end

    def render_attachment_link(attachment:, no_delete:, label_override:, filename_label:)
      default_label = context.tag.i('', class: "fa #{RadCommon::ContentTypeIcon.new(attachment.content_type)}") +
                      filename_label

      attachment_label = label_override.presence || default_label

      context.safe_join([context.link_to(attachment_label,
                                         context.url_for(attachment),
                                         target: '_blank',
                                         rel: :noopener,
                                         class: 'btn btn-secondary attachment-link text-wrap'),
                         render_delete_attachment_link(attachment: attachment, no_delete: no_delete)])
    end
end
