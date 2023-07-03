Rails.application.routes.draw do
  get 'landing', to: 'landing#index', as: 'landing'
  root "landing#index"

  devise_for :users, path: ''
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
