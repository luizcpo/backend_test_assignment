require 'rails_helper'

RSpec.describe UserRecommendedCar, type: :model do
  subject { build(:user_recommended_car) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:car) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:car_id) }
  end
end
