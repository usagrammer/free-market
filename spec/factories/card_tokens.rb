FactoryBot.define do
  factory :card, aliases: [:card_token] do
    card_token { "car_xxxxxxxxxxxxx" }
    customer_token { "cus_xxxxxxxxxxxxx" }
    association :user
  end
end
