# frozen_string_literal: true

class RecommendationSerializer < ActiveModel::Serializer
  attributes :id, :brand, :model, :price, :rank_score, :label

  def brand
    {
      "id": object.brand_id,
      "name": object.brand&.name,
    }
  end

  def rank_score
    object.user_recommended_car&.rank_score
  end

  def label
    price_range = @instance_options.dig(:serializer_options, :price_range)
    brands = @instance_options.dig(:serializer_options, :brands)
    
    return 'perfect_match' if price_range.include?(object.price) && brands.include?(object.brand_id)
    return 'good_match' if brands.include? object.brand_id
    return nil
  end
end
  