FactoryBot.define do
  factory :car do
    brand { create(:brand) }
    model { Faker::Vehicle.model }
    price { rand(5000..1000000) }
  end
end
