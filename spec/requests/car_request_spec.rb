# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cars', type: :request do
  describe 'GET /index' do
    context 'with user_id' do
      let(:user) { create(:user) }

      before do
        query_double = double('CarSearchService', recomendations: [])
        allow(CarSearchService).to receive(:new).and_return(query_double)
      end

      it 'returns http success' do
        get '/cars', params: { user_id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'without user_id' do
      it 'returns http success' do
        get '/cars'
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
