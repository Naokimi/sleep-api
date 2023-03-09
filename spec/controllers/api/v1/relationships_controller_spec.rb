require 'rails_helper'

describe Api::V1::RelationshipsController, type: :controller do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user1_id) { user1.id }
  let(:user2_id) { user2.id }

  describe '#follow' do
    subject { post :follow, params: { user_id: user1_id, follower_id: user2_id }, format: :json }

    context 'with valid params' do
      it 'creates a new relationship' do
        expect(user1.followers).to be_empty
        subject
        expect(response).to have_http_status(:created)
        expect(user1.followers).to include(user2)
      end
    end

    context 'with invalid params' do
      let(:user2_id) { 0 }

      it 'returns an error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Validation failed: Follower must exist')
      end
    end
  end

  describe '#unfollow' do
    before { FactoryBot.create(:relationship, followed: user1, follower: user2) }

    subject { delete :unfollow, params: { user_id: user1_id, follower_id: user2_id }, format: :json }

    context 'with valid params' do
      it 'destroy existing relationship' do
        expect(user1.followers).to include(user2)
        subject
        expect(response).to have_http_status(:ok)
        expect(user1.followers).to be_empty
      end
    end

    context 'with invalid params' do
      let(:user2_id) { 0 }

      it 'returns an error message' do
        expect(user1.followers.count).to eq(1)
        subject
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq("User #{user2_id} doesn't follow user #{user1_id}")
        expect(user1.followers.count).to eq(1)
      end
    end
  end
end
