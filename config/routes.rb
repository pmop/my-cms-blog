Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :posts
  get 'tags/(/:permalink)', to: 'tags#index', as: :search_by_tag

  get '/users', to: 'users#index', as: :users
  get '/users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
