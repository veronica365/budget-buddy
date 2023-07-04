Rails.application.routes.draw do
  get 'landing', to: 'landing#index', as: 'landing'

  # Defines the root path route ("/")
  root "landing#index"

  devise_for :users, path: ''
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
