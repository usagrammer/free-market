FactoryBot.define do
  factory :sns_credential do
    provider { "google_oauth2" }
    uid { rand(100000000000000000000..999999999999999999999) }
    association :user
  end
end
