Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  root to: 'home#index'

  resources :comments
  resources :posts, except: [:index] do
    resource :comments, shallow: true
  end

  resource :tags

  get '/users/:id', to: 'users#show', as: :user
  get 'dashboard', to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
