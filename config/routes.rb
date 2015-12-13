Rails.application.routes.draw do
  root "pages#index"

  resources :collections do
    member do
      post :add_posts
      get :recent_posts
    end
  end
end
