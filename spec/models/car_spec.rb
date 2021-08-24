require 'rails_helper'

RSpec.describe Car, type: :model do
  subject { build(:car) }

  describe 'associations' do
    it { is_expected.to belong_to(:brand) }
    it { is_expected.to have_one(:user_recommended_car) }
  end
end
