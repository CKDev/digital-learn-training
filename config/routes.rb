Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get 'home_language_toggle', to: 'home#language_toggle'
  resources :pages, only: [:show]
  resources :courses, only: [:index, :show], path: "trainings" do
    post :start
    get :complete
    get "attachment/:attachment_id" => "courses#view_attachment", as: :attachment
    resources :lessons, only: [:index, :show] do
      get :lesson_complete
      post :complete
    end
  end
  resources :course_materials, only: [:index, :show], path: "courses" do
    resources :course_materials_files, only: [:index, :show]
    resources :course_materials_medias, only: [:index, :show]
  end
  resources :categories, only: [:show]

  namespace :admin do
    root "course_materials#index"
    resources :pages, except: [:destroy]
    resources :pages_archive, only: [:index]
    resources :courses, except: [:destroy], path: "trainings" do
      put :sort, on: :collection
      resources :lessons, except: [:index] do
        put :sort, on: :collection
        delete :destroy_asl_attachment, on: :collection
      end
    end
    resources :courses_archive, only: [:index], path: "trainings_archive"
    resources :course_materials, except: [:destroy], path: "courses" do
      put :sort, on: :collection
    end
    resources :course_materials_archive, only: [:index], path: "courses_archive"
    resources :categories, except: [:destroy]
    resources :attachments, only: [:destroy]
  end

  namespace :att do
    get 'login'
  end

  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    passwords: "passwords",
    saml_sessions: "saml_sessions"
  }

  match "/404", to: "errors#error_404", via: [:all]
  match "/422", to: "errors#error_422", via: [:all]
  match "/500", to: "errors#error_500", via: [:all]

  root to: "home#index"
end
