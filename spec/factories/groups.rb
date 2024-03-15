FactoryBot.define do
  factory :group do
    user
    name { Faker::Lorem.word }
  end
end
