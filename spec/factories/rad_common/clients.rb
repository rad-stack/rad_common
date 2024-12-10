FactoryBot.define do
  factory :client, class: RadCommon::AppInfo.new.client_model_class_name do
    name { Faker::Company.name }
    valid_user_domains { ['abc.com'] }
    email { 'joe@abc.com' }
  end
end
