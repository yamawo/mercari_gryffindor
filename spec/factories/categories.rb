FactoryBot.define do
  factory :category do
    ancestry  {"1"}
    name  {Faker::Name.name}
  end
end
