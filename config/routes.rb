Rails.application.routes.draw do
  devise_for :users
  resources :tickets do
  member do
    patch :mark_done
  end
end

  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "tickets#index"
end
