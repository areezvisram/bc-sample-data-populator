Rails.application.routes.draw do
  get 'products/index'
  get 'products/create'
  get 'app/index'
  get 'sessions/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'app#index'

  # get "/auth/bigcommerce/callback" => "sessions#create"
  # get "/auth/failure" => redirect('/')
  match '/auth/bigcommerce', to: 'sessions#new', via: [:get]
  match '/auth/bigcommerce/callback', to: 'sessions#create', via: [:get, :post]
  match '/auth/failure', to: redirect('/'), via: [:get, :post]


  resources :products, only: [:index, :create]

  get '/load' => 'app#load'
end
