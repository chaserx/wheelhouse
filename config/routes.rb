Rails.application.routes.draw do
  resources :organizations, only: [:new, :show, :create]
  root 'organizations#new'
  get '*unmatched_route', to: 'application#not_found'
end
