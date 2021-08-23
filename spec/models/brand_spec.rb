require 'rails_helper'

RSpec.describe Brand, type: :model do
  subject { build(:brand) }

  describe 'associations' do
    it { is_expected.to have_many(:cars) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
