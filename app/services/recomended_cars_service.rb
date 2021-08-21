class RecomendedCarsService < ApplicationService
    def recomendations(user_id)
        @options = { 
          :query => { 
            :user_id => user_id 
          } 
        }
        get_recomended_cars
        @recomendations
    end

    private
    def get_recomended_cars
        res = HTTParty.get('https://bravado-images-production.s3.amazonaws.com/recomended_cars.json', @options)
        @recomendations = JSON.parse(res.body)
    end
end