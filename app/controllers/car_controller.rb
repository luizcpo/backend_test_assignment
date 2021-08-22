class CarController < ApplicationController
    def index
      config_params
      fetch_info

      search_service = CarSearchService.new(params, 
                                            @brands, 
                                            @priceRange)

      pagy,result = pagy_array(search_service.recomendations, page: params[:page])
            
      render json: result, 
             each_serializer: RecomendationSerializer,
             serializer_options: { brands: @brands, priceRange: @priceRange }
    end

    private
    def config_params
      params.require(:user_id)
      params[:user_id] = params[:user_id]&.to_i
      params[:price_min] = params[:price_min]&.to_i
      params[:price_max] = params[:price_max]&.to_i
      params[:page] = params[:page]&.to_i
    end

    def fetch_info
      @priceRange = User.find(params[:user_id]).preferred_price_range
      @brands = UserPreferredBrand.where(user_id: params[:user_id]).pluck(:brand_id)
    end
end
