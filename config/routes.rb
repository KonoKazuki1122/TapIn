Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  authenticate :user do
    root to: "dashboard#index", as: :dashboard
    resource  :slack_config, only: [:edit, :update]
    resources :nfc_tags
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root to: redirect("/users/sign_in")
end
