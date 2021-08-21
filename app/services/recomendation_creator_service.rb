class recomendation_creator_service < ApplicationService
    def create_user_recomended_car(recomendation, user_id) 
      urc = UserRecomendedCar.find_by_car_id_and_user_id(recomendation.car_id, user_id)
        
      if urc
        urc.rank_score = recomendation.rank_score
      else
        urc = UserRecomendedCar.new({
          :user_id => user_id,
          :car_id => recomendation.car_id,
          :rank_score => recomendation.rank_score
        })
      end
      
      urc.save
    end
end