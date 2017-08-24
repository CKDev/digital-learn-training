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
  resources :course_materials, only: [:show] do
    resources :course_materials_files, only: [:index, :show]
    resources :course_materials_medias, only: [:index, :show]
  end
  resources :categories, only: [:show]

  namespace :admin do
    root "pages#index"
    resources :pages, except: [:destroy]
    resources :pages_archive, only: [:index]
    resources :courses, except: [:destroy] do
      put :sort, on: :collection
      resources :lessons do
        put :sort, on: :collection
        delete :destroy_asl_attachment, on: :collection
      end
    end
    resources :courses_archive, only: [:index]
    resources :course_materials, except: [:destroy]
    resources :course_materials_archive, only: [:index]
    resources :categories
    resources :attachments, only: [:destroy]
  end
end
