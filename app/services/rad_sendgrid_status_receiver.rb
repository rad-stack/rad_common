class RadSendgridStatusReceiver
  def initialize(content)
    @content = content
    check_events
  end

  def process!
    Notifications::SendgridEmailStatusNotification.main.notify! @content
  end

  def email
    @content[:email].downcase
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def event
    @content[:event].downcase
  end

  def record_id
    # legacy support for post_id, remove this eventually, see Task 41177
    @content[:record_id].presence || @content[:post_id]
  end

  def host_name
    @content[:host_name]
  end

  def suppression?
    suppression_events.include?(event)
  end

  def timestamp
    DateTime.strptime(@content['timestamp'].to_s, '%s')
  end

  def user_agent
    @content[:useragent].presence || 'Unknown'
  end

  def url
    @content[:url]
  end

  private

    def check_events
      raise "unknown event type #{event}" unless all_events.include?(event)
    end

    def all_events
      suppression_events + %w[open click]
    end

    def suppression_events
      ['dropped', 'bounce', 'spam report']
    end
end
