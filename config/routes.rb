Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :people
  end

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :show, :create] do
        resource :detail, only: [:show, :create]
      end
    end
  end

  # Defines the root path route ("/")
  root "admin/people#index"
end
