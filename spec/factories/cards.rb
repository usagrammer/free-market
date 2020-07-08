FactoryBot.define do
  factory :card do
    card_token { "" }
    customer_token { "" }
    association :user
  end
end
