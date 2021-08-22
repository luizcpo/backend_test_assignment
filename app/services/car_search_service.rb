# frozen_string_literal: true

class CarSearchService < ApplicationService
    def initialize(params, brands, price_range)
      @priceRange = price_range
      @brands = brands
      @query = params[:query]
      @page = params[:page]
      @priceMax = params[:price_max]
      @priceMin = params[:price_min]
    end

    def recomendations
      results = Car.brands_and_order

      results = results.with_query(@query) if @query
      results = results.with_price_max(@priceMax) if @priceMax
      results = results.with_price_min(@priceMin) if @priceMin
      
      if @query.nil? && @priceMax.nil? && @priceMin.nil?
        perfect_match = results.perfect_match(@priceRange, @brands)
        good_match = results.good_match(@priceRange, @brands)
        top_5_with_scores = results.top_5_with_scores
        
        first_results = Set[]
        first_results.merge(perfect_match)
        first_results.merge(good_match)
        first_results.merge(top_5_with_scores)

        ids = first_results.pluck(:id)

        results = first_results.merge(results.where.not(id: ids)).to_a
      end
      
      results = results.to_a unless results.is_a? Array

      return results
    end
  
    def create_all_user_recomended_cars
      User.all.each do |user|
        RecomendedCarCreatorWorker.perform_async(user.id)
      end
    end
  end