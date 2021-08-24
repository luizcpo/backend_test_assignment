FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    preferred_price_range { rand(5000..50000)..rand(50001..100000) }

    trait :with_preferred_brands do
      transient do
        user_preferred_brands_count { 2 }
      end

      after(:create) do |user, evaluator|
        create_list(:user_preferred_brand, evaluator.user_preferred_brands_count, users: [user])
        user_preferred_brand.reload
      end
    end

    trait :with_recommended_cars do
      transient do
        user_recommended_cars_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:user_recommended_car, evaluator.user_recommended_cars_count, users: [user])
        user_recommended_car.reload
      end
    end
  end
end
