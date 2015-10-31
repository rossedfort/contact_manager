Rails.application.routes.draw do
  root 'people#index'

  resources :companies
  resources :email_addresses
  resources :phone_numbers
  resources :people
end
