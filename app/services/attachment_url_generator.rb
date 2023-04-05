class AttachmentUrlGenerator
  def self.permanent_attachment_variant_url(record, variant)
    protocol = Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    host = RadConfig.host_name!
    record_id = Hashable.hashids.encode(record.id)
    class_name = record.class.model_name.route_key
    "#{protocol}://#{host}/rad_common/attachments/#{class_name}/#{record_id}/#{variant}"
  end

  def self.permanent_attachment_url(attachment)
    protocol = Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    host = RadConfig.host_name!
    record_id = Hashable.hashids.encode(attachment.id)
    "#{protocol}://#{host}/rad_common/attachments/#{record_id}"
  end
end
