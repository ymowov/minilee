Rails.application.routes.draw do
  root "pages#index"

  resources :collections do
    member do
      post :add_posts
    end
    collection do
      post :recent_posts
    end
  end
end
