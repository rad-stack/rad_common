class DuplicatesMatcher
  attr_accessor :record

  def initialize(record)
    self.record = record
  end

  def matches
    contacts = []

    record.all_matches.each do |match|
      item = model_klass.find(match)
      score = record.duplicate_record_score(item)
      contacts.push(id: item.id, score: score)
    end

    contacts.sort_by { |item| item[:score] }.reverse.first(100)
  end

  private

    def model_klass
      @model_klass ||= record.class.to_s.constantize
    end
end
