Rails.application.routes.draw do
  get "notifications/index"
  get "departments/index"
  get "departments/new"
  get "departments/create"
  get "departments/edit"
  get "departments/update"
  get "departments/destroy"
  get "departments/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  #  root "employee_details#index"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}

  authenticated :user do
    root to: "user_details#index", as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new"
    end
  end
  

  resources :user_details
  # resources :employee_details
  resources :products
  resources :departments

  resources :attendances, only: [:index] do
   collection do
    post :check_in
   end

   member do
    patch :check_out
   end
  end

  resources :leave_requests, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :leave_requests do
  member do
    patch :approve
    patch :reject
  end
  end

  resource :profile, only: [:show, :edit, :update , :destroy]
  # resources :profiles, only: [:show]

  resources :notifications, only: [:index]




  namespace :api do
  namespace :v1 do

    post "login", to: "auth#login"

    resources :users
    resources :departments

  end
end
end


