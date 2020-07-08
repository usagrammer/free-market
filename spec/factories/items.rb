FactoryBot.define do
  factory :item do
    name { Faker::Food.fruits }
    price { rand(300..9999999) }
    detail { Faker::Lorem.sentence }
    condition { rand(0..5) }
    delivery_fee_payer { rand(0..1) }
    delivery_method  { rand(0..8) }
    prefecture_id { rand(1..47) }
    delivery_days  { rand(0..2) }
    deal  { rand(0..1) }
    association :category, :grandchild
    association :seller

    trait :with_images do
      transient do
        image_length { 1 }  ## 引数のイメージ（evaluator.image_lengthで使える）
      end
      after(:build) { |item, evaluator| item.images << build_list(:image, evaluator.image_length)}
    end

    trait :with_buyer do
      association :buyer
    end

  end
end
