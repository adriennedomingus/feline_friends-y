Rails.application.routes.draw do
  root to: "landing#show"

  resources :cats, only: [:index, :show]

  resources :categories, only: [:show], param: :name

  resources :carts, only: [:create]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :show, :create]

  namespace "admin" do
    get "/dashboard", to: "orders#index"
    resources :orders, only: [:show, :update]
    resources :cats, only: [:new, :create]
  end

  get "/cart", to: "carts#show"
  delete "/cart", to: "carts#destroy"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/dashboard", to: "users#show"
end
