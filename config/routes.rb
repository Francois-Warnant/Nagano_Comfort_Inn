NaganoComfortInn::Application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}

  namespace :gestion do
    resources :users, only: [:show, :index, :new, :create]  do
      resources :reservations, controller: "users/reservations"
    end

    resources :reservations, only: [:index, :new, :create], controller: "reservations"

    resources :rooms
    resources :room_types
    resources :view_types
    resources :room_reservations
  end

  namespace :client do
    resources :profiles, only: [:show, :edit, :update]

    resources :reservations, only: [:show, :index, :create, :new, :edit, :update] do
      resources :room_reservations, only: [:edit, :index, :update], controller: "reservations/room_reservations"
    end

  end

  resources :rooms, only: [:show, :index]

  root to: 'pages_generale#home'

  match '/my_profile', to: 'client/profiles#edit'
  match '/new_reservation', to: 'client/reservations#new'
  match '/my_reservation', to: 'client/reservations/room_reservations#index'
  match '/change_room', to: 'client/reservations/room_reservations#edit'
end
