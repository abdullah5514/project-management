require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let!(:user) { create(:user) }
  let(:valid_credentials) { { email: user.email, password: 'password' } }
  let(:invalid_credentials) { { email: 'invalid@example.com', password: 'wrong_password' } }

  describe 'POST /api/v1/login' do
    context 'when credentials are valid' do
      it 'logs the user in and returns a token' do
        post '/api/v1/login', params: valid_credentials

        expect(response).to have_http_status(:ok)
        expect(json['token']).to be_present
      end
    end

    context 'when credentials are invalid' do
      it 'returns an error message' do
        post '/api/v1/login', params: invalid_credentials

        expect(response).to have_http_status(:not_found)
        expect(json['error']).to eq('User not found')
      end
    end
  end

  describe 'DELETE /api/v1/logout' do
    context 'when logged in' do
      let(:token) { user.generate_jwt }

      it 'logs the user out and returns no content' do
        delete '/api/v1/logout', headers: { 'Authorization' => "Bearer #{token}" }

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
