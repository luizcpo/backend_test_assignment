# frozen_string_literal: true

class RecomendationCreatorService < ApplicationService

  def create_all_user_recomended_cars
    User.all.each do |user|
      RecomendedCarCreatorWorker.perform_async(user.id)
    end
  end
end