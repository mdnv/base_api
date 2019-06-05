Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: "json" } do
    resource :users, only: [:create] do
      collection do
        post "/sign_in", to: "sessions#create"
        delete "/sign_out", to: "sessions#destroy"
      end
    end
  end
end
