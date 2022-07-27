Rails.application.routes.draw do
  resources :users, defaults: {format: :json}

  # users
  post "/login", to: "users#login"

  # categories
  get "/categories", to: "category#index"
  post "/categories", to: "category#create"
 
end
