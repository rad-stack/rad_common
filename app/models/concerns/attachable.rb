module Attachable
  def permanent_attachment_url(attachment, variant)
    protocol = Rails.env.production? ? 'https' : 'http'
    host = Rails.env.production? ? ENV.fetch('HOST_NAME') : 'localhost:3000'
    attachment_id = Hashable.hashids.encode(send(attachment).id)
    "#{protocol}://#{host}/rad_common/attachments/#{attachment_id}/#{variant}"
  end
end
