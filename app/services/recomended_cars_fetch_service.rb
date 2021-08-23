# frozen_string_literal: true

class RecomendedCarsFetchService < ApplicationService
  include HTTParty
  base_uri 'https://bravado-images-production.s3.amazonaws.com'

  def initialize(user_id)
    @user_id = user_id
    @options = { 
      :query => { 
        :user_id => @user_id
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
      self.class.get('/recomended_cars.json', @options)
    end
    @recomendations = JSON.parse(res.body)
  end
end