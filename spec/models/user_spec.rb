require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { FactoryBot.build(:user) }

    context 'when valid' do
      it 'returns true' do
        expect(user.valid?).to be_truthy
      end
    end

    context 'with missing name' do
      it 'returns false' do
        user.name = nil
        expect(user.valid?).to be_falsey
      end
    end
  end
end
