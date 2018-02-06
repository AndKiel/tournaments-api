# == Route Map
#
#               Prefix Verb   URI Pattern                        Controller#Action
#                 root GET    /                                  tournaments#index
#          oauth_token POST   /oauth/token(.:format)             doorkeeper/tokens#create
#         oauth_revoke POST   /oauth/revoke(.:format)            doorkeeper/tokens#revoke
#     oauth_token_info GET    /oauth/token/info(.:format)        doorkeeper/token_info#show
#        sign_up_users POST   /users/sign_up(.:format)           users#sign_up
#                 user GET    /user(.:format)                    users#show
#                      PATCH  /user(.:format)                    users#update
#                      PUT    /user(.:format)                    users#update
# enlisted_tournaments GET    /tournaments/enlisted(.:format)    tournaments#enlisted
#     start_tournament POST   /tournaments/:id/start(.:format)   tournaments#start
#       end_tournament POST   /tournaments/:id/end(.:format)     tournaments#end
#          tournaments GET    /tournaments(.:format)             tournaments#index
#                      POST   /tournaments(.:format)             tournaments#create
#           tournament GET    /tournaments/:id(.:format)         tournaments#show
#                      PATCH  /tournaments/:id(.:format)         tournaments#update
#                      PUT    /tournaments/:id(.:format)         tournaments#update
#                      DELETE /tournaments/:id(.:format)         tournaments#destroy
#       add_competitor POST   /competitor/add(.:format)          competitors#add
#           competitor DELETE /competitor(.:format)              competitors#destroy
#                      POST   /competitor(.:format)              competitors#create
#   confirm_competitor POST   /competitors/:id/confirm(.:format) competitors#confirm
#    reject_competitor POST   /competitors/:id/reject(.:format)  competitors#reject
#               rounds POST   /rounds(.:format)                  rounds#create
#                round PATCH  /rounds/:id(.:format)              rounds#update
#                      PUT    /rounds/:id(.:format)              rounds#update
#                      DELETE /rounds/:id(.:format)              rounds#destroy
#              players POST   /players(.:format)                 players#create
#               player PATCH  /players/:id(.:format)             players#update
#                      PUT    /players/:id(.:format)             players#update
#

Rails.application.routes.draw do
  root 'tournaments#index'

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
    collection do
      get :enlisted
    end
    member do
      post :start
      post :end
    end
  end

  resource :competitor, only: %i[create destroy] do
    member do
      post :add
    end
  end
  resources :competitors, only: :none do
    member do
      post :confirm
      post :reject
    end
  end

  resources :rounds, only: %i[create update destroy]

  resource :players, only: :create
  resources :players, only: :update
end
