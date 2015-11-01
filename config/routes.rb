Rails.application.routes.draw do
  root 'welcome#index'

  resources :companies
  resources :email_addresses
  resources :phone_numbers
  resources :people
end
