# frozen_string_literal: true

class RecomendedCarsFetchService < ApplicationService
  def initialize(user_id)
    @userId = user_id
    @options = { 
      :query => { 
        :user_id => @userId
      } 
    }
  end

  def recomendations
    get_recomended_cars
    @recomendations
  end

  private
  def get_recomended_cars
    res = Rails.cache.fetch(1, expires_in: 24.hours) do 
      HTTParty.get('https://bravado-images-production.s3.amazonaws.com/recomended_cars.json', @options)
    end
    @recomendations = JSON.parse(res.body)
  end
end