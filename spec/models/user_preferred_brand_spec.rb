require 'rails_helper'

RSpec.describe UserPreferredBrand, type: :model do
  subject { build(:user_preferred_brand) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:brand) }
  end
end
