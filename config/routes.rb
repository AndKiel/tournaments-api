# == Route Map
#
#                 Prefix Verb   URI Pattern                                      Controller#Action
#                   root GET    /                                                application#ping
#            oauth_token POST   /oauth/token(.:format)                           doorkeeper/tokens#create
#           oauth_revoke POST   /oauth/revoke(.:format)                          doorkeeper/tokens#revoke
#       oauth_token_info GET    /oauth/token/info(.:format)                      doorkeeper/token_info#show
#          sign_up_users POST   /users/sign_up(.:format)                         users#sign_up
#                   user GET    /user(.:format)                                  users#show
#                        PATCH  /user(.:format)                                  users#update
#                        PUT    /user(.:format)                                  users#update
#       start_tournament POST   /tournaments/:id/start(.:format)                 tournaments#start
#         end_tournament POST   /tournaments/:id/end(.:format)                   tournaments#end
#  tournament_competitor DELETE /tournaments/:tournament_id/competitor(.:format) competitors#destroy
#                        POST   /tournaments/:tournament_id/competitor(.:format) competitors#create
#      tournament_rounds POST   /tournaments/:tournament_id/rounds(.:format)     rounds#create
#            tournaments GET    /tournaments(.:format)                           tournaments#index
#                        POST   /tournaments(.:format)                           tournaments#create
#             tournament GET    /tournaments/:id(.:format)                       tournaments#show
#                        PATCH  /tournaments/:id(.:format)                       tournaments#update
#                        PUT    /tournaments/:id(.:format)                       tournaments#update
#                        DELETE /tournaments/:id(.:format)                       tournaments#destroy
#     confirm_competitor POST   /competitors/:id/confirm(.:format)               competitors#confirm
#                  round PATCH  /rounds/:id(.:format)                            rounds#update
#                        PUT    /rounds/:id(.:format)                            rounds#update
#                        DELETE /rounds/:id(.:format)                            rounds#destroy
# apipie_apipie_checksum GET    /docs/apipie_checksum(.:format)                  apipie/apipies#apipie_checksum {:format=>/json/}
#          apipie_apipie GET    /docs(/:version)(/:resource)(/:method)(.:format) apipie/apipies#index {:version=>/[^\/]+/, :resource=>/[^\/]+/, :method=>/[^\/]+/}
#

Rails.application.routes.draw do
  root 'application#ping'

  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications
  end

  resources :users, only: :none do
    collection do
      post :sign_up
    end
  end
  resource :user, only: %i[show update]
  resources :tournaments, only: %i[index show create update destroy] do
    member do
      post :start
      post :end
    end

    resource :competitor, only: %i[create destroy]
    resources :rounds, only: %i[create]
  end
  resources :competitors, only: :none do
    member do
      post :confirm
    end
  end
  resources :rounds, only: %i[update destroy]

  apipie
end
