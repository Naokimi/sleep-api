require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe '#create' do
    subject { post :create, params: { user: { name: name } }, format: :json }

    context 'with valid params' do
      let(:name) { 'Bob Marley' }

      it 'creates a new user' do
        subject
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
        expect(User.last.name).to eq(name)
      end
    end

    context 'with invalid params' do
      let(:name) { nil }

      it 'returns an error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include("can't be blank")
        expect(User.count).to eq(0)
      end
    end
  end

  describe '#destroy' do
    let!(:user) { FactoryBot.create(:user) }

    subject { delete :destroy, params: { id: id }, format: :json }

    context 'with valid params' do
      let(:id) { user.id }

      it 'destroys a new user' do
        subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq("User #{id} successfully deleted")
        expect(User.count).to eq(0)
      end
    end

    context 'with invalid params' do
      let(:id) { 0 }

      it 'returns an error message' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq("Couldn't find User with 'id'=#{id}")
        expect(User.count).to eq(1)
      end
    end
  end
end
