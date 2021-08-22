class Car < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :brand
  has_one :user_recomended_car, dependent: :destroy

  scope :with_query, -> (query) { joins('RIGHT JOIN brands ON brands.id = cars.brand_id').where('brands.name LIKE ?', "%#{sanitize_sql_like(query)}%") }
  scope :with_price_max, -> (price_max) { where('price <= ?', price_max) }
  scope :with_price_min, -> (price_min) { where('price >= ?', price_min) }
  scope :perfect_match, -> (price_range, brands) { where(brand_id: brands, price: price_range) }
  scope :good_match, -> (price_range, brands) { where(brand_id: brands) }
  scope :top_5_with_scores, -> { joins('RIGHT JOIN user_recomended_cars ON user_recomended_cars.car_id = cars.id').order('user_recomended_cars.rank_score DESC').limit(5) }
  scope :brands_and_order, -> { includes(:brand, :user_recomended_car).order('price ASC') }
end
