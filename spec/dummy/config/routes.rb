Rails.application.routes.draw do
  devise_for :customers
  resources :products
  mount Cartify::Engine, at: '/'
  root controller: :products, action: :index
end
