FactoryBot.define do
  factory :category do  ## 親カテゴリ
    name     { Faker::Lorem.characters(number: 10, min_alpha: 4) }
    ancestry { nil }

    trait :child do  ## 子カテゴリ
      after(:build) do |category|
        category.parent = FactoryBot.create(:category)
      end
    end

    trait :grandchild do  ## 孫カテゴリ（itemと紐付けるのはこれ）
      after(:build) do |category|
        category.parent = FactoryBot.create(:category, :child)
      end
    end

  end
end
