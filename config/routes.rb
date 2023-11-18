Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # ゲストログイン機能
  devise_scope :user do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :coordinates, only: [:index, :show, :destroy]
  end

  scope module: :public do
    root to: "homes#top"
    resources :users, only: [:show, :edit, :update] do
      member do
        patch :deactivate
        get :posts
        get :bookmarks
      end
    end
    resources :coordinates do
      resource :bookmarks, only: [:create, :destroy]
      resources :actions, only: [:create, :destroy]
      collection do
        get :random
      end
    end
    get "/search", to: "searches#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
