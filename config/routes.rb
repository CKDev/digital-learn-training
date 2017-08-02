Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :pages, only: [:show]

  resources :courses, only: [:index, :show] do
    post 'start'
    post 'add'
    post 'remove'
    get 'complete'
    get 'attachment/:attachment_id' => 'courses#view_attachment', as: :attachment
    get 'skills', to: 'courses#skills', as: :skills
    resources :lessons, only: [:index, :show] do
      get 'lesson_complete'
      post 'complete'
    end
  end

  namespace :admin do
    root "pages#index"
    resources :pages

    resources :courses do
      put :sort, on: :collection

      resources :lessons do
        collection do
          delete :destroy_asl_attachment
        end
      end
    end
  end
end
