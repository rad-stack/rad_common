module Attachable
  include Hashable

  def permanent_attachment_url(variant)
    protocol = Rails.env.production? ? 'https' : 'http'
    host = Rails.env.production? ? ENV.fetch('HOST_NAME') : 'localhost:3000'
    "#{protocol}://#{host}/rad_common/attachments/#{encoded_id}/download?class=#{self.class}&variant=#{variant}"
  end
end
