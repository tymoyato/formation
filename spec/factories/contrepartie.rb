FactoryBot.define do
  factory :contrepartie, class: Contrepartie do
    contribution_id { Faker::Number.number(5) }
    name            { Faker::Vehicle.make_and_model }
    amount          { Faker::Number.number(5) }
    stock_state     { Faker::Boolean.boolean }
  end
end