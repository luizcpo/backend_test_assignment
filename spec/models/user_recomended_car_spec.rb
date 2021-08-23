require 'rails_helper'

RSpec.describe UserRecomendedCar, type: :model do
  subject { build(:user_recomended_car) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:car) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:car_id) }
  end
end
