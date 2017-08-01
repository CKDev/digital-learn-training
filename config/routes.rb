Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :pages, only: [:show]
  namespace :admin do
    root "pages#index"
    resources :pages
  end
end
