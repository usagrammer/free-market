FactoryBot.define do
  factory :user, aliases: [:seller, :buyer] do  ## aliasesで:sellerと:buyerとして使えるようになる
    email {Faker::Internet.email}
    password { "hogehogefugafuga123" }
    nickname { Faker::Name.name}
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    first_name_reading { Gimei.first.katakana }
    last_name_reading { Gimei.last.katakana }
    birthday { Faker::Date.birthday}
    association :address

    trait :with_selling_items do
      transient do
        selling_item_length { 1 }  ## 引数のイメージ（evaluator.item_lengthで使える）
      end
      after(:build) { |user, evaluator| user.selling_items << build_list(:item, evaluator.selling_item_length)}
    end

    trait :with_bought_items do
      transient do
        bought_item_length { 1 }  ## 引数のイメージ（evaluator.item_lengthで使える）
      end
      after(:build) { |user, evaluator| user.bought_items << build_list(:item, evaluator.bought_item_length)}
    end

  end

end
