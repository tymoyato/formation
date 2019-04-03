FactoryBot.define do
  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    date_of_birth         { Date.today }
    password              { Faker::Internet.password }
    password_confirmation { password }
  end
end
