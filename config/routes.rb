Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :pages, only: [:show]
  resources :courses, only: [:index, :show] do
    post :start
    get :complete
    get "attachment/:attachment_id" => "courses#view_attachment", as: :attachment
    resources :lessons, only: [:index, :show] do
      get :lesson_complete
      post :complete
    end
  end
  resources :course_materials, only: [:show]
  resources :categories, only: [:show]

  namespace :admin do
    root "pages#index"
    resources :pages
    resources :courses do
      put :sort, on: :collection
      resources :lessons do
        put :sort, on: :collection
        delete :destroy_asl_attachment, on: :collection
      end
    end
    resources :course_materials
    resources :attachments, only: [:destroy]
  end
end
