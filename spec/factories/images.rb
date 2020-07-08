FactoryBot.define do
  factory :image do
    src {File.open("#{Rails.root}/public/uploads/test_image/test1.png")}
  end
end
