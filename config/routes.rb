NaganoComfortInn::Application.routes.draw do
  devise_for :users

  namespace :gestion do
    resources :users, only: [:show, :index, :new, :create]  do
      resources :reservations
    end

    resources :reservations, only: [:index]

    #resources :cleaning
    resources :rooms
    resources :room_types
    resources :view_types
  end

  namespace :client do
    resources :profiles, only: [:show, :edit, :update]
    resources :reservations, only: [:show, :index, :create, :new, :edit, :update]
  end

  resources :rooms, only: [:show, :index]

  root to: 'pages_generale#home'

  match '/my_profile', to: 'client/profiles#edit'
  match '/new_reservation', to: 'client/reservations#new'


end
