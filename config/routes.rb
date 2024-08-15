Rails.application.routes.draw do
  get 'users/index'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  devise_for :users

  authenticated :user do
    root 'events#index', as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  post 'create_event_a', to: 'events#create_event_a'
  post 'create_event_b', to: 'events#create_event_b'

  resources :events, only: [:index]
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
end
