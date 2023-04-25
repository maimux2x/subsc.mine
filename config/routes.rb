Rails.application.routes.draw do
  root to: 'welcome#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :users do
    resources :subscriptions, only: %i(index)
  end
  
  resource :retirements
  
  resources :users, only: %i(show)
  resources :sessions, only: %i(new create destroy)
  resources :welcome, only: %i(index)
  resources :subscriptions, only: %i(index new create edit update destroy)

  namespace :subscriptions do
    resources :status, only: %i(edit update)
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
