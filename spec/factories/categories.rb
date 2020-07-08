FactoryBot.define do
  factory :category do
    name     { Faker::Lorem.characters(number: 10, min_alpha: 4) }
    ancestry { nil }
  end

  trait :child do
    parent = FactoryBot.create(:category)
    ancestry { parent.id }
  end

  trait :grandchild do
    child = FactoryBot.create(:category, :child)
    ancestry { child.parent.id.to_s + "/" + child.id.to_s }
  end
end
