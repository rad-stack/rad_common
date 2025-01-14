class AttachmentUrlGenerator
  def self.permanent_attachment_variant_url(record, variant, include_filename: false)
    protocol = Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    host = RadConfig.host_name!
    record_id = Hashable.hashids.encode(record.id)
    class_name = record.class.model_name.route_key
    item = "#{protocol}://#{host}/attachments/#{class_name}/#{record_id}/#{variant}"
    return item unless include_filename

    "#{item}/#{URI::Parser.new.escape(record.logo_variant.filename)}"
  end

  def self.permanent_attachment_url(attachment, include_filename: false)
    protocol = Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    host = RadConfig.host_name!
    record_id = Hashable.hashids.encode(attachment.id)
    item = "#{protocol}://#{host}/attachments/#{record_id}"
    return item unless include_filename

    "#{item}/#{URI::Parser.new.escape(attachment.filename)}"
  end
end
