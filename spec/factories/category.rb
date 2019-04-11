FactoryBot.define do
  factory :category, class: Category do
    name { Faker::Name.name }
  end
end
