Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users, skip: [:registrations]
  root to: 'home#index'
  resources :posts, except: [:index]


  get 'tags/(/:permalink)', to: 'tags#index', as: :search_by_tag
  get '/users/:id', to: 'users#show', as: :user
  get 'dashboard', to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
