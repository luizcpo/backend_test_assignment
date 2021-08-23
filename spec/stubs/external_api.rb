# frozen_string_literal: true

class ExternalApi
  def self.default_stub(user_id: 0)
    WebMock.stub_request(:get, 'https://bravado-images-production.s3.amazonaws.com/recomended_cars.json')
           .with(query: { user_id: user_id })
  end

  def self.stub_success(user_id: 0)
    default_stub(user_id: user_id)
      .to_return(
        status: 200,
        body: default_response.to_json,
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def self.stub_error(user_id: 0)
    default_stub(user_id: user_id).to_return(status: 500)
  end

  def self.default_response
    [
      { "car_id": 179, "rank_score": 0.945 },
      { "car_id": 5, "rank_score": 0.4552 },
      { "car_id": 180, "rank_score": 0.567 },
      { "car_id": 97, "rank_score": 0.9489 },
      { "car_id": 86, "rank_score": 0.2183 },
      { "car_id": 32, "rank_score": 0.0967 },
      { "car_id": 176, "rank_score": 0.0353 },
      { "car_id": 177, "rank_score": 0.1657 },
      { "car_id": 186, "rank_score": 0.7068 },
      { "car_id": 103, "rank_score": 0.4729 }
    ]
  end
end