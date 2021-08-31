Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :survivors, only: [:index, :create, :update]
      resources :trades , only: [:create]
      resources :reports , only: [:index]
      resources :infection_reports, only: [:create]
    end
  end
end
