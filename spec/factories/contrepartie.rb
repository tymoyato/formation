FactoryBot.define do
  factory :contrepartie, class: Contrepartie do
    project_id { Faker::Number.number(5) }
    name            { Faker::Vehicle.make_and_model }
    amount          { Faker::Number.number(2) }
    stock_state     { Faker::Boolean.boolean }
  end
end
