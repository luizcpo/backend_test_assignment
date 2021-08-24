# frozen_string_literal: true

class RecommendedCarCreatorWorker
    include Sidekiq::Worker

    sidekiq_options retry: 5
  
    def perform(user_id)

      service = RecommendedCarsFetchService.new(user_id)
      recommendations = service.recommendations

      recommendations.each do |rec|
        create_user_recommended_car(rec, user_id)
      end 
    end

    private
    def create_user_recommended_car(recommendation, user_id) 
      urc = UserRecommendedCar.find_by_car_id_and_user_id(recommendation['car_id'], user_id)
        
      if urc
        urc.rank_score = recommendation['rank_score']
      else
        urc = UserRecommendedCar.new({
          :user_id => user_id,
          :car_id => recommendation['car_id'],
          :rank_score => recommendation['rank_score']
        })
      end
      
      urc.save
    end
  end
  