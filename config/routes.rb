Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts do
    get 'search', on: :collection
  end

  resource :tags

  get '/users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
