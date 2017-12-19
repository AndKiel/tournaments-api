require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST #sign_up' do
    context 'when params are valid' do
      it 'returns User', :show_in_doc do
        expect do
          post sign_up_users_path,
               params: {
                 user: {
                   email: 'sign.up@mail.co',
                   password: 'password',
                   password_confirmation: 'password'
                 }
               }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status :created
        expect(response.body).to match_json_expression user_json
      end
    end

    context 'when params are not valid' do
      it 'returns validation errors', :show_in_doc do
        expect do
          post sign_up_users_path,
               params: {
                 user: {
                   email: ''
                 }
               }
        end.to_not change(User, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to match_json_expression errors_json
      end
    end
  end

  context 'when authenticated' do
    authenticate(:john_smith)

    describe 'GET #show' do
      it 'returns authenticated User', :show_in_doc do
        get user_path,
            headers: auth_headers
        expect(response).to have_http_status :ok
        expect(response.body).to match_json_expression user_json
      end
    end

    describe 'PUT #update' do
      it 'updates authenticated User', :show_in_doc do
        put user_path,
            headers: auth_headers,
            params: {
              user: {
                email: 'one.updated@mail.co'
              }
            }
        expect(response).to have_http_status :ok
        expect(response.body).to match_json_expression user_json
        expect(current_user.attributes).to_not eq(current_user.reload.attributes)
      end
    end
  end
end
