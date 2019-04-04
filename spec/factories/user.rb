FactoryBot.define do
  factory :user do
    first_name            { 'ervin' }
    last_name             { 'duttoo' }
    email                 { 'ervin@email.fr' }
    date_of_birth         { Date.today }
    password              { 'foobar' }
    password_confirmation { 'foobar' }
  end

  factory :random_user, class: User do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    date_of_birth         { Date.today }
    password              { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
