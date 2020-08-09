FactoryBot.define do
  factory :card, aliases: [:card_token] do  ## aliasesで:card_tokenとして使えるようになる
    card_token { "car_xxxxxxxxxxxxx" }
    customer_token { "cus_xxxxxxxxxxxxx" }
    association :user
  end
end
