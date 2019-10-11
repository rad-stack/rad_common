module Attachable
  include Hashable

  def permanent_attachment_url(variant)
    protocol = Rails.env.production? ? 'https' : 'http'
    host = Rails.env.production? ? ENV.fetch('HOST_NAME') : 'localhost:3000'
    attachment_id = Hashable.hashids.encode(send(variant).blob.attachments.first.id)
    "#{protocol}://#{host}/common/attachments/#{attachment_id}/#{variant}"
  end
end
