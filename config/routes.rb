Rails.application.routes.draw do
  root "pages#home"
  
  get "signup", to: "users#new"
  post "users", to: "users#create"
  
  get "login", to: "sessions#new"
  post "sessions", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :places do
    resources :entries, only: [:new, :create]
  end
end
