FactoryBot.define do
  factory :list do
    name { Faker::Lorem.word }
    user
  end
end
