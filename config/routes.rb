Rails.application.routes.draw do

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
    resources :course_attachments, only: [:index]
    resources :course_materials_files, only: [:index, :show]
    resources :course_materials_medias, only: [:index, :show]
  end
  resources :categories, only: [:show]
  resources :templates, only: [:index]
  resources :contribute, only: [:index]
  resource :collaborator_warnings, only: [:destroy]

  # SSO With Learners Site
  resource :learners_sessions, only: [:new], path: "learners_sessions" do
    get "/callback", to: "learners_sessions#callback", as: :oauth_callback
  end

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
    resources :course_material_imports, only: [:index, :create, :destroy]
    resources :course_materials_archive, only: [:index], path: "courses_archive"
    resources :categories, except: [:destroy]
    resources :attachments, only: [:destroy]
  end

  namespace :att do
    get 'login'
  end

  resources :access_requests, only: [:new, :create]

  devise_for :users, controllers: {
    sessions: "sessions",
    registrations: "registrations",
    passwords: "passwords",
    saml_sessions: "saml_sessions",
    invitations: "invitations"
  }, skip: [:registrations]

  as :user do
    get   'users/edit' => 'registrations#edit',   as: 'edit_user_registration'
    patch 'users'      => 'registrations#update', as: 'user_registration'
    put   'users'      => 'registrations#update'
  end

  match "/404", to: "errors#error_404", via: [:all]
  match "/422", to: "errors#error_422", via: [:all]
  match "/500", to: "errors#error_500", via: [:all]

  # Honeypot route for bots/researchers
  get "/admin/login", to: "errors#error_404"

  root to: "home#index"
end
