FactoryBot.define do
  factory :random_user, class: User do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    date_of_birth         { Date.today }
    password              { 'foobar' }
    password_confirmation { 'foobar' }
    confirmed_at          { Time.now }
  end
end
