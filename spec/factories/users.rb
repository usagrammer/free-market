FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password { "hogehogefugafuga123"}
    nickname { Faker::Name.name}
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    first_name_reading { Gimei.first.katakana }
    last_name_reading { Gimei.last.katakana }
    birthday { Faker::Date.birthday}
  end
end
