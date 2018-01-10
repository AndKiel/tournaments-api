require 'rails_helper'

RSpec.describe 'OAuth', type: :request do
  describe 'POST /oauth/token' do
    let(:user) { users(:andrew) }

    context 'valid params' do
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
        expect(response.body).to match_json_expression(access_token_json)
      end
    end

    context 'invalid params' do
      it 'returns error' do
        post oauth_token_path,
             params: {
               email: user.email,
               password: 'password',
               grant_type: 'invalid_grant'
             }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match_json_expression(error_json)
      end
    end
  end

  describe 'GET /oauth/token/info' do
    context 'when authenticated' do
      authenticate(:anne)

      it 'returns AccessToken details' do
        get oauth_token_info_path,
            headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_expression(access_token_info_json)
      end
    end

    context 'when not authenticated' do
      it 'returns error' do
        get oauth_token_info_path
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match_json_expression(error_json)
      end
    end
  end

  describe 'POST /oauth/revoke' do
    it 'revokes AccessToken' do
      post oauth_revoke_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression({})
    end
  end
end
