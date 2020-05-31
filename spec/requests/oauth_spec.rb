# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OAuth', type: :request do
  describe 'POST /oauth/token' do
    let(:user) { create(:user) }

    context 'with valid params' do
      it 'creates AccessToken' do
        expect do
          post oauth_token_path,
               params: {
                 email: user.email,
                 password: 'password',
                 grant_type: 'password'
               }
        end.to change(Doorkeeper::AccessToken, :count).by(1)
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema('access_token')
      end
    end

    context 'with invalid params' do
      it 'returns error' do
        post oauth_token_path,
             params: {
               email: user.email,
               password: 'password',
               grant_type: 'invalid_grant'
             }
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to match_json_schema('error')
      end
    end
  end

  describe 'GET /oauth/token/info' do
    context 'when authenticated' do
      authenticate

      it 'returns AccessToken details' do
        get oauth_token_info_path,
            headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema('access_token_info')
      end
    end

    context 'when unauthenticated' do
      it 'returns error' do
        get oauth_token_info_path
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match_json_schema('token_info_error')
      end
    end
  end

  describe 'POST /oauth/revoke' do
    authenticate

    it 'revokes AccessToken' do
      post oauth_revoke_path,
           params: {
             token: access_token.token
           }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('{}')
    end
  end
end
