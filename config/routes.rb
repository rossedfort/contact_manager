Rails.application.routes.draw do
  root 'welcome#index'

  resources :companies
  resources :email_addresses
  resources :phone_numbers
  resources :people

  get '/auth/:provider/callback' => 'sessions#create'
  resource :sessions, :only => [:create]
  get "/login" => redirect("/auth/twitter"), as: :login
  delete "/logout" => "sessions#destroy", as: :logout
end
