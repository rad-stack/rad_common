class SmsLogStore
  Message = Struct.new(:from_number, :to_number, :to_user_id, :to_user_name, :body, :media_url, :sent_at, keyword_init: true)

  class << self
    def enabled?
      Rails.env.development?
    end

    def log(from_number:, to_number:, to_user: nil, body:, media_url: nil)
      return unless enabled?

      messages << Message.new(
        from_number: from_number,
        to_number: to_number,
        to_user_id: to_user&.id,
        to_user_name: to_user&.to_s,
        body: body,
        media_url: media_url,
        sent_at: Time.current
      )
    end

    def messages
      @messages ||= []
    end

    def messages_for_user(user_id)
      messages.select { |m| m.to_user_id == user_id }.sort_by(&:sent_at)
    end

    def users_with_messages
      messages.group_by(&:to_user_id).map do |user_id, user_messages|
        latest = user_messages.max_by(&:sent_at)
        {
          user_id: user_id,
          user_name: latest.to_user_name || latest.to_number,
          to_number: latest.to_number,
          message_count: user_messages.size,
          last_message_at: latest.sent_at,
          last_message_preview: latest.body.truncate(80)
        }
      end.sort_by { |u| u[:last_message_at] }.reverse
    end

    def clear!
      @messages = []
    end
  end
end
