class DuplicatesProcessor
  attr_accessor :record, :bypass_notifications

  def initialize(record, bypass_notifications: false)
    self.record = record
    self.bypass_notifications = bypass_notifications
  end

  def run!
    contacts = record.duplicate_matches

    if contacts.any?
      raw_score = contacts.first[:score]
      record.create_or_update_metadata!({ duplicates_info: contacts.to_json,
                                          score: raw_score.positive? ? raw_score : nil },
                                        bypass_notifications: bypass_notifications)
    else
      record.create_or_update_metadata!({ duplicates_info: nil, score: nil },
                                        bypass_notifications: bypass_notifications)
    end
  end
end
