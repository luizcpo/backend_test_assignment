FactoryBot.define do
  factory :user_recomended_car do
    user { create(:user) }
    car { create(:car) }
    rank_score { rand(0.0..1.0) }
    
  end
end
