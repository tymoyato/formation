FactoryBot.define do
  factory :contribution, class: Contribution do
    user_id    { Faker::Number.number(5) }
    project_id { Faker::Number.number(5) }
    amount     { Faker::Number.number(3) }
  end
end
