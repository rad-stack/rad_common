FactoryBot.define do
  factory :custom_report do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    report_model { 'User' }
    configuration do
      {
        columns: [
          { field: 'id', label: 'ID' },
          { field: 'name', label: 'Name' }
        ],
        filters: [],
        joins: []
      }
    end
  end
end
