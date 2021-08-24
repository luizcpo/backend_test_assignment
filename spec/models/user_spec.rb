require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:user_preferred_brands) }
    it { is_expected.to have_many(:user_recommended_cars) }
    it { is_expected.to have_many(:preferred_brands) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:preferred_price_range) }
  end
end
