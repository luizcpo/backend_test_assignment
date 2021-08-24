# frozen_string_literal: true

class CarSearchService < ApplicationService
    def initialize(params, brands, price_range)
      @price_range = price_range
      @brands = brands
      @query = params[:query]
      @page = params[:page]
      @user_id = params[:user_id]
      @price_max = params[:price_max]
      @price_min = params[:price_min]
    end

    def recommendations
      results = Car.brands_and_order

      results = results.with_query(@query) if @query
      results = results.with_price_max(@price_max) if @price_max
      results = results.with_price_min(@price_min) if @price_min
      
      if @query.nil? && @price_max.nil? && @price_min.nil?
        perfect_match = results.perfect_match(@price_range, @brands)
        good_match = results.good_match(@price_range, @brands)
        top_5_with_scores = results.top_5_with_scores(@user_id)
        
        first_results = Set[]
        first_results.merge(perfect_match)
                     .merge(good_match)
                     .merge(top_5_with_scores)

        ids = first_results.pluck(:id)

        results = first_results.merge(results.where.not(id: ids)).to_a
      end
      
      results = results.to_a unless results.is_a? Array

      return results
    end
  
    def create_all_user_recommended_cars
      User.all.each do |user|
        RecommendedCarCreatorWorker.perform_async(user.id)
      end
    end
  end