# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Rails.env.production?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  5.times do |i|
    FactoryBot.create(:category)
  end

  5.times do |i|
    FactoryBot.create(:project)
  end

  5.times do |i|
    FactoryBot.create(:random_user, email: "activated#{i}@test.com")
  end

  5.times do |i|
    FactoryBot.create(:random_user, email: "desactivated#{i}@test.com")
  end
end
