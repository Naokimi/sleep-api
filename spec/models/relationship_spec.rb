require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validations' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:relationship) { FactoryBot.build(:relationship, follower: user1, followed: user2) }

    context 'when valid' do
      it 'returns true' do
        expect(relationship.valid?).to be_truthy
      end
    end

    context 'with existing relationship' do
      before { FactoryBot.create(:relationship, follower: user1, followed: user2) }

      it 'returns false' do
        expect(relationship.valid?).to be_falsey
      end
    end
  end
end
