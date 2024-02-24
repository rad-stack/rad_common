class DuplicatesProcessor
  attr_accessor :model_class, :bypass_notifications, :rake_session

  def initialize(model_name, bypass_notifications: false, rake_session: nil)
    self.rake_session = rake_session
    self.model_class = model_name.constantize
    self.bypass_notifications = bypass_notifications
  end

  def all!
    reset_session

    records.each do |record|
      break if check_session_status

      record! record
    end
  end

  def record!(record)
    items = DuplicatesMatcher.new(record).matches

    if items.any?
      raw_score = items.first[:score]
      record.create_or_update_metadata!({ duplicates_info: items.to_json,
                                          score: raw_score.positive? ? raw_score : nil },
                                        bypass_notifications: bypass_notifications)
    else
      record.create_or_update_metadata!({ duplicates_info: nil, score: nil },
                                        bypass_notifications: bypass_notifications)
    end
  end

  private

    def reset_session
      return if rake_session.blank?

      rake_session.reset_status
    end

    def check_session_status
      return false if rake_session.blank?

      rake_session.check_status("checking #{model_name} records for duplicates", count)
    end

    def records
      @records ||= model_class.duplicates_to_process
    end

    def count
      @count ||= @records.size
    end

    def model_name
      @model_name ||= model_class.to_s
    end
end
