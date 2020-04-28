Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :posts
  resources :tags do
    collection do
      get 'search'
    end
  end

  get '/users', to: 'users#index', as: :users
  get '/users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
