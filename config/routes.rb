Rails.application.routes.draw do
  resources :songs, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]

  resources :songs, only: [] do
    resources :comments, only: [ :new ]
    resources :media_files, only: [ :new ]
    resources :lyrics_versions, only: [ :new ]
  end

  resources :comments, only: [ :show, :edit, :update, :create, :destroy ]
  resources :media_files, only: [ :show, :edit, :update, :create, :destroy ]
  resources :lyrics_versions, only: [ :show, :edit, :update, :create, :destroy ] do
    post "accept" => "lyrics_versions#accept"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "songs#index"
end
