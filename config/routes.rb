Rails.application.routes.draw do
  devise_for :users


  resources :tickets do
    member do
      patch :mark_done
    end
    resources :histories, only: [ :index ]
    resources :comments, only: [ :create, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check


  root "tickets#index"
end
