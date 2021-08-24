# frozen_string_literal: true

class RecommendationCreatorService < ApplicationService

  def create_all_user_recommended_cars
    User.all.each do |user|
      RecommendedCarCreatorWorker.perform_async(user.id)
    end
  end
end