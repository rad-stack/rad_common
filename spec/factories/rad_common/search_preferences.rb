FactoryBot.define do
  factory :search_preference do
    user
    search_class { 'UserSearch' }
    toggle_behavior { :remember_state }
    sticky_filters { true }
    search_filters { {} }
  end
end
