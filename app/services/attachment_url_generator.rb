class AttachmentUrlGenerator
  def self.permanent_attachment_variant_url(record, variant)
    protocol = Rails.env.production? ? 'https' : 'http'
    host = Rails.env.production? ? ENV.fetch('HOST_NAME') : 'localhost:3000'
    record_id = Hashable.hashids.encode(record.id)
    class_name = record.class.model_name.route_key
    "#{protocol}://#{host}/rad_common/attachments/#{class_name}/#{record_id}/#{variant}"
  end
end
