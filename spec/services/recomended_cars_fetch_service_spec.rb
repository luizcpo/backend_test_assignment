# frozen_string_literal: true

require 'rails_helper'

describe RecomendedCarsFetchService, type: :service do
  subject { described_class.new(user_id: 1) }

  before do
    ExternalApi.stub_success(user_id: 1)
  end

  describe '#recomendations' do
    xit 'calls the right URL and the user id' do
      subject.recomendations
      url = 'https://bravado-images-production.s3.amazonaws.com/recomended_cars.json?user_id=1'
      expect(WebMock).to have_requested(:get, url).once
    end

    context 'when response is successful' do
      xit 'returns a list of cars and scores' do
        expect(subject.recomendations.size).to eq(10)
      end
    end
  end
end
