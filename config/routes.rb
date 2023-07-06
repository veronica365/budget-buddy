Rails.application.routes.draw do
  get 'landing', to: 'landing#index', as: 'landing'

  # Defines the root path route ("/")
  root "landing#index"

  devise_for :users, path: ''
  resources :categories, only: [:index, :new, :show, :create, :edit, :destroy] do
    resources :transactions
  end
  match '*unmatched', to: 'application#not_found_method', via: :all
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
