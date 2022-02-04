FactoryBot.define do
  factory :client, class: RadCommon::AppInfo.new.client_model_class_name do
    sequence(:name) { |n| "Client #{n}" }
    valid_user_domains { ['abc.com'] }
  end
end
