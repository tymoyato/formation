FactoryBot.define do
  factory :project, class: Project do
    name       { Faker::Name.name }
    short_desc { Faker::Lorem.paragraph(2) }
    long_desc  { Faker::Lorem.paragraph(40) }
    amount     { Faker::Number.number(5) }
    landscape  { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/team.png'))) }
    thumb      { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/team.png'))) }
    category
  end
end
