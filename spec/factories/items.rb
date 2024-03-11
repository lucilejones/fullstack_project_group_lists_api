FactoryBot.define do
  factory :item do
    list
    name { Faker::Lorem.word }
    brand { Faker::Lorem.word }
    store { Faker::Lorem.word }
    notes { Faker::Lorem.paragraph }
    need_to_purchase { Faker::Boolean.boolean }
  end
end
