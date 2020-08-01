FactoryBot.define do
  factory :address do
    phone_number { Faker::PhoneNumber.cell_phone.gsub(/[^\d]/, "") }
    prefecture_id { rand(1..47) }
    postal_code { "#{rand(100..999)}-#{rand(1000..9999)}" }
    city { Faker::Address.city }
    house_number { Faker::Address.building_number }
    building_name { Faker::Address.street_name }
  end
end
