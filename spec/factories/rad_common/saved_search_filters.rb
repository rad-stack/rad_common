FactoryBot.define do
  factory :saved_search_filter do
    user
    name { Faker::Company.bs }
    search_class { 'UserSearch' }
    search_filters { { 'email_like' => Faker::Internet.email } }
  end
end
