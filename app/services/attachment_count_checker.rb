class AttachmentCountChecker
  def self.check_attachment(model_name, paperclip_attachment_name, active_storage_attachment_name)
    model = model_name.constantize
    paperclip_count = model.where("#{paperclip_attachment_name}_file_name is not null").count
    active_storage_count = model.joins("#{active_storage_attachment_name}_attachment").count
    message = "#{model_name} \nPaperclip Count (#{paperclip_attachment_name}) - #{paperclip_count} \n"
    message += "Active Storage Count (#{active_storage_attachment_name}) - #{active_storage_count}"

    Rails.logger.info(message)
  end
end
