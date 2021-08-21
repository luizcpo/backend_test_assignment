# frozen_string_literal: true

class RecomendedCarCrawlerWorker
    include Sidekiq::Worker

    sidekiq_options retry: 5

    def perform
      service = RecomendationCreatorService.new
      service.create_all_user_recomended_cars
    end
  end
  