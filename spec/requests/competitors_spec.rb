# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Competitors', type: :request do
  authenticate

  let(:tournament) { create(:tournament) }

  describe 'POST /competitor' do
    context 'when it is possible to enlist' do
      context 'with valid params' do
        it 'creates Competitor' do
          expect do
            post competitor_path,
                 headers: auth_headers,
                 params: {
                   tournament_id: tournament.id,
                   competitor: {
                     name: 'Hellen'
                   }
                 }
          end.to change(Competitor, :count).by(1)
          expect(response).to have_http_status(:created)
          expect(response.body).to match_json_schema('responses/competitor')
        end
      end

      context 'with invalid params' do
        it 'returns validation errors' do
          post competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id,
                 competitor: {
                   name: ''
                 }
               }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_schema('responses/validation_error')
        end
      end
    end

    context 'when it is not possible to enlist' do
      let(:tournament) { create(:tournament, :in_progress) }

      it 'returns error' do
        post competitor_path,
             headers: auth_headers,
             params: {
               tournament_id: tournament.id
             }
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_schema('responses/error')
      end
    end
  end

  describe 'DELETE /competitor' do
    before { create(:competitor, tournament: tournament, user: current_user) }

    context 'when it is possible to resign' do
      it 'deletes Competitor' do
        expect do
          delete competitor_path,
                 headers: auth_headers,
                 params: {
                   tournament_id: tournament.id
                 }
        end.to change(Competitor, :count).by(-1)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
      end
    end

    context 'when it is not possible to resign' do
      let(:tournament) { create(:tournament, :ended) }

      before { create(:competitor, tournament: tournament, user: current_user) }

      it 'returns error' do
        delete competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id
               }
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_schema('responses/error')
      end
    end
  end

  context 'when authenticated as tournament organiser' do
    let(:tournament) { create(:tournament, organiser: current_user) }

    describe 'POST /competitors/add' do
      context 'when conditions for adding competitor are met' do
        context 'with valid params' do
          it 'creates Competitor' do
            expect do
              post add_competitor_path,
                   headers: auth_headers,
                   params: {
                     tournament_id: tournament.id,
                     competitor: {
                       name: 'External'
                     }
                   }
            end.to change(Competitor, :count).by(1)
            expect(response).to have_http_status(:created)
            expect(response.body).to match_json_schema('responses/competitor')
          end
        end

        context 'with invalid params' do
          it 'returns validation errors' do
            post add_competitor_path,
                 headers: auth_headers,
                 params: {
                   tournament_id: tournament.id,
                   competitor: {
                     name: ''
                   }
                 }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to match_json_schema('responses/validation_error')
          end
        end
      end

      context 'when conditions for adding competitor are not met' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }

        it 'returns error' do
          post add_competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id
               }
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end

    describe 'DELETE /competitors/:id/remove' do
      context 'when conditions for remove are met' do
        let!(:competitor) { create(:competitor, :anonymous, tournament: tournament) }

        it 'deletes Competitor' do
          delete remove_competitor_path(competitor.id),
                 headers: auth_headers
          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
        end
      end

      context 'when conditions for remove are not met' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }
        let!(:competitor) { create(:competitor, :anonymous, tournament: tournament) }

        it 'returns error' do
          delete remove_competitor_path(competitor.id),
                 headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end

    describe 'POST /competitors/:id/confirm' do
      context 'when conditions for confirm are met' do
        let!(:competitor) { create(:competitor, :anonymous, tournament: tournament) }

        it 'updates Competitor' do
          post confirm_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/competitor')
          expect(competitor.reload.status).to eq('confirmed')
        end
      end

      context 'when conditions for confirm are not met' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }
        let!(:competitor) { create(:competitor, :anonymous, tournament: tournament) }

        it 'returns error' do
          post confirm_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end

    describe 'POST /competitors/:id/reject' do
      context 'when conditions for reject are met' do
        let!(:competitor) { create(:competitor, :anonymous, :confirmed, tournament: tournament) }

        it 'updates Competitor' do
          post reject_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/competitor')
          expect(competitor.reload.status).to eq('enlisted')
        end
      end

      context 'when conditions for reject are not met' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }
        let!(:competitor) { create(:competitor, :anonymous, :confirmed, tournament: tournament) }

        it 'returns error' do
          post reject_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end
  end
end
