# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST #sign_up' do
    context 'with valid params' do
      it 'returns User' do
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
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_schema('responses/user')
      end
    end

    context 'with invalid params' do
      it 'returns validation errors' do
        expect do
          post sign_up_users_path,
               params: {
                 user: {
                   email: ''
                 }
               }
        end.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_schema('errors/validation_error')
      end
    end
  end

  context 'when authenticated' do
    authenticate

    describe 'GET #show' do
      it 'returns authenticated User' do
        get user_path,
            headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema('responses/user')
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'updates authenticated User' do
          put user_path,
              headers: auth_headers,
              params: {
                user: {
                  email: 'one.updated@mail.co'
                }
              }
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/user')
          expect(current_user.attributes).not_to eq(current_user.reload.attributes)
        end
      end

      context 'with invalid params' do
        it 'returns error' do
          put user_path,
              headers: auth_headers,
              params: {
                user: {
                  email: 'invalid'
                }
              }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_schema('errors/validation_error')
        end
      end
    end
  end
end
