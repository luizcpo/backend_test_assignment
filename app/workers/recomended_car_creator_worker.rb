# frozen_string_literal: true

class RecomendedCarCreatorWorker
    include Sidekiq::Worker

    sidekiq_options retry: 5
  
    def perform(user_id)

      service = RecomendedCarsFetchService.new(user_id)
      recomendations = service.recomendations

      recomendations.each do |rec|
        create_user_recomended_car(rec, user_id)
      end 
    end

    private
    def create_user_recomended_car(recomendation, user_id) 
      urc = UserRecomendedCar.find_by_car_id_and_user_id(recomendation['car_id'], user_id)
        
      if urc
        urc.rank_score = recomendation['rank_score']
      else
        urc = UserRecomendedCar.new({
          :user_id => user_id,
          :car_id => recomendation['car_id'],
          :rank_score => recomendation['rank_score']
        })
      end
      
      urc.save
    end
  end
  