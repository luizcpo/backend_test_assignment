# frozen_string_literal: true

class RecommendedCarCrawlerWorker
    include Sidekiq::Worker

    sidekiq_options retry: 5

    def perform
      service = RecommendationCreatorService.new
      service.create_all_user_recommended_cars
    end
  end
  