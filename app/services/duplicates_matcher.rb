class DuplicatesMatcher
  attr_accessor :record

  def initialize(record)
    self.record = record
  end

  def matches
    contacts = []

    all_matches.each do |match|
      item = model_klass.find(match)
      score = record.duplicate_record_score(item)
      contacts.push(id: item.id, score: score)
    end

    contacts.sort_by { |item| item[:score] }.reverse.first(100)
  end

  private

    def all_matches
      # TODO remove send
      (record.send(:name_matches) + record.send(:similar_name_matches) + record.send(:birth_date_matches) + record.send(:additional_item_matches)).uniq - model_klass.no_matches(record)
    end

    def model_klass
      @model_klass ||= record.class.to_s.constantize
    end
end
