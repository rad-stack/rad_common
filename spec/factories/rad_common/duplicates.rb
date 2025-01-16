FactoryBot.define do
  factory :duplicate do
    duplicatable factory: %i[attorney]
    processed_at { Time.current }
  end
end
