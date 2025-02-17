class CreateUserRecommendedCars < ActiveRecord::Migration[6.1]
  def change
    create_table :user_recommended_cars do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.float :rank_score

      t.timestamps
    end
    add_index :user_recommended_cars, [:user_id, :car_id], unique: true
  end
end
