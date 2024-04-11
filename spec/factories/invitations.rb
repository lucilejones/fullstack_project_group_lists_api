FactoryBot.define do
  factory :invitation do
    sender { nil }
    recipient { nil }
    group { nil }
    accepted { false }
  end
end
