NaganoComfortInn::Application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

  namespace :gestion do
    resources :users, only: [:show, :index, :new, :create]  do
      resources :reservations, only: [:index], controller: "users/reservations"
    end

    resources :reservations, only: [:index, :new, :create], controller: "reservations"

    resources :rooms, only: [:index]
    resources :room_types, only: [:index, :new, :create]
    resources :view_types, only: [:index, :new, :create]
  end

  namespace :client do
    resources :profiles, only: [:show, :edit, :update]

    resources :reservations, only: [:index, :create, :new, :edit, :update] do
      resources :room_reservations, only: [:edit, :index, :update], controller: "reservations/room_reservations"
    end
  end

  resources :rooms, only: [:show, :index]

  root to: 'pages_generale#home'

  match '/new_reservation', to: 'client/reservations#new'
  match '/my_reservation', to: 'client/reservations/room_reservations#index'
  match '/my_reservations', to: 'client/reservations#index'
end
