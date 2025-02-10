Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :users, only: [ :show, :edit, :update, :destroy ] do
    member do
      post :follow
      get "edit_password", to: "users#edit_user_password"
      patch "update_password", to: "users#update_user_password"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_chec

  resources :artworks do
    member do
      post :like
    end
    resources :comments, only: [ :create, :destroy, :edit, :update ]
  end

  resources :artist_details

  post "change_language", to: "application#change_language", as: :change_language

  root to: "artworks#index"
end
