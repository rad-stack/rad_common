module Attachable
  include Hashable

  def encoded_url(variant)
    protocol = Rails.env.production? ? 'https' : 'http'
    host = Rails.env.production? ? ENV.fetch('HOST_NAME') : 'localhost:3000'
    "#{protocol}://#{host}/rad_common/attachments/#{encoded_id}/download?class=#{self.class}&variant=#{variant}"
  end
end
