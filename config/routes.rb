Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  get "up" => "rails/health#show", as: :rails_health_chec

  resources :artworks do
    member do
      post :like
    end
  end

  root to: "artworks#index"
end
