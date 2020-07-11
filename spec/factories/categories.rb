FactoryBot.define do
  factory :category do
    name     { Faker::Lorem.characters(number: 10, min_alpha: 4) }
    ancestry { nil }

    trait :child do
      after(:build) do |category|
        category.parent = FactoryBot.create(:category)
      end
    end

    trait :grandchild do
      after(:build) do |category|
        category.parent = FactoryBot.create(:category, :child)
      end
    end

  end

end
