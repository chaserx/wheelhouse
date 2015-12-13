Rails.application.routes.draw do
  resources :organizations, only: [:new, :show, :create]
  root 'organizations#new'
end
