FactoryBot.define do
  factory :list do
    user
    name { Faker::Lorem.word }
  end
end
