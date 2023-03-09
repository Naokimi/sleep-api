require 'rails_helper'

describe Api::V1::SleepSessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }

  describe '#clock_in' do
    subject { post :clock_in, params: { user_id: user_id }, format: :json }

    context 'with valid conditions' do
      it 'creates a new sleep session' do
        expect(SleepSession.count).to eq(0)
        subject
        expect(response).to have_http_status(:created)
        expect(user.sleep_sessions.count).to eq(1)
      end
    end

    context 'with invalid id' do
      let(:user_id) { 0 }

      it 'returns an error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq("Couldn't find User with 'id'=#{user_id}")
        expect(SleepSession.count).to eq(0)
      end
    end

    context 'with existing sleep session' do
      before { FactoryBot.create(:sleep_session, user: user, ended_at: nil) }

      it 'returns an error message' do
        expect(SleepSession.count).to eq(1)
        subject
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq("There is already an active sleep session for user #{user_id}")
        expect(SleepSession.count).to eq(1)
      end
    end
  end

  describe '#clock_out' do
    subject { patch :clock_out, params: { user_id: user_id }, format: :json }

    context 'with valid conditions' do
      before { FactoryBot.create(:sleep_session, user: user, ended_at: nil) }

      it 'records ended_at for the sleep session' do
        subject
        expect(response).to have_http_status(:ok)
        expect(user.sleep_sessions.last.ended_at).not_to be_nil
      end
    end

    context 'with invalid id' do
      let(:user_id) { 0 }

      it 'returns an error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq("Couldn't find User with 'id'=#{user_id}")
      end
    end

    context 'with no sleep session' do
      it 'returns an error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq("There is no active sleep session for user #{user_id}")
      end
    end
  end

  describe '#index' do
    subject { get :index, params: { user_id: user_id }, format: :json }

    before do
      FactoryBot.create(:sleep_session, user: user, created_at: 2.years.ago)
      FactoryBot.create(:sleep_session, user: user)
    end

    it 'returns all sleep sessions of the user sorted by creation date' do
      subject
      expect(response).to have_http_status(:ok)
      sleep_sessions = JSON.parse(response.body)['sleep_sessions']
      expect(sleep_sessions.length).to eq(2)
      expect(sleep_sessions.first['created_at']).to be > sleep_sessions.last['created_at']
    end
  end
end
