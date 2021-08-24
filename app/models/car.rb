class Car < ApplicationRecord
  belongs_to :brand
  has_one :user_recommended_car, dependent: :destroy

  scope :with_query, -> (query) { joins('RIGHT JOIN brands ON brands.id = cars.brand_id').where('brands.name LIKE ?', "%#{sanitize_sql_like(query)}%") }
  scope :with_price_max, -> (price_max) { where('price <= ?', price_max) }
  scope :with_price_min, -> (price_min) { where('price >= ?', price_min) }
  scope :perfect_match, -> (price_range, brands) { where(brand_id: brands, price: price_range).includes(:brand, :user_recommended_car) }
  scope :good_match, -> (price_range, brands) { where(brand_id: brands).includes(:brand, :user_recommended_car) }
  scope :top_5_with_scores, -> (user_id)  { joins('INNER JOIN user_recommended_cars ON user_recommended_cars.car_id = cars.id').where('user_recommended_cars.user_id = ?', user_id) }
  scope :brands_and_order, -> { includes(:brand, :user_recommended_car).order('price ASC') }
end
